var _jeremy8883$home_mirror$Native_LocalStorage = (() => {
  const get = (key) => {
    const value = localStorage.getItem(key);
    return value ? _elm_lang$core$Maybe$Just(JSON.parse(value)) : _elm_lang$core$Maybe$Nothing;
  };

  const set = (key, value) => {
    localStorage.setItem(key, JSON.stringify(value));
    return _elm_lang$core$Maybe$Nothing;
  };

  const remove = (key) => {
    localStorage.removeItem(key);
    return _elm_lang$core$Maybe$Nothing;
  };

  return { get, set, remove };
})();
