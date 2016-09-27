// pull in desired CSS/SASS files
require( './styles/main.css' );

// inject bundled Elm app into div#main
// config is injected from the webpack DefinePlugin
var Elm = require( '../elm/Main' );
Elm.Main.embed( document.getElementById( 'main' ), config );
