var path              = require( 'path' );
var webpack           = require( 'webpack' );
var merge             = require( 'webpack-merge' );
var HtmlWebpackPlugin = require( 'html-webpack-plugin' );
var ExtractTextPlugin = require( 'extract-text-webpack-plugin' );
var CopyWebpackPlugin = require( 'copy-webpack-plugin' );

console.log( 'WEBPACK GO!');

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';
const isProduction = TARGET_ENV === 'production';

// common webpack config
var commonConfig = {

  output: {
    path:       path.resolve( __dirname, 'dist/' ),
    filename: '[hash].js',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions:         ['', '.js', '.elm']
  },

  module: {
    noParse: /\.elm$/,
    loaders: [
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      }
    ]
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/static/index.html',
      inject:   'body',
      filename: 'index.html'
    }),
    new webpack.DefinePlugin({
      config: JSON.stringify(require('./.private/config.json')),
    })
  ],

  postcss: function postcssInit(webpackInstance) {
    const plugins = [
      require('postcss-import')({
        addDependencyTo: webpackInstance,
      }),
      require('postcss-mixins'),
      require('postcss-cssnext'),
      require('postcss-nested'),
    ];
    const prodOnlyPlugins = [
      require('cssnano')({
        safe: true,
        autoprefixer: false,
        sourcemap: true,
      }),
    ];

    return isProduction ? plugins.concat(prodOnlyPlugins) : plugins;
  },
};

// additional webpack settings for local env (when invoked by 'npm start')
if ( !isProduction ) {
  console.log( 'Serving locally...');

  module.exports = merge( commonConfig, {

    entry: [
      'webpack-dev-server/client?http://localhost:8090',
      path.join( __dirname, 'src/static/index.js' )
    ],

    devServer: {
      inline:   true,
      progress: true,
      port: 8090,
    },

    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-hot!elm-webpack?verbose=true&warn=true'
        },
        {
          test: /\.css$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
          ]
        }
      ]
    }
  });
} else if ( isProduction ) {
  console.log( 'Building for prod...');

  module.exports = merge( commonConfig, {

    entry: path.join( __dirname, 'src/static/index.js' ),

    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-webpack'
        },
        {
          test: /\.css$/,
          loader: ExtractTextPlugin.extract( 'style-loader', [
            'css-loader',
            'postcss-loader',
          ])
        }
      ]
    },

    plugins: [
      new CopyWebpackPlugin([
        {
          from: 'src/static/images/',
          to:   'static/images/'
        },
        {
          from: 'src/favicon.ico'
        },
      ]),

      new webpack.optimize.OccurenceOrderPlugin(),

      // extract CSS into a separate file
      new ExtractTextPlugin( './[hash].css', { allChunks: true } ),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
          minimize:   true,
          compressor: { warnings: false }
          // mangle:  true
      })
    ]

  });
}
