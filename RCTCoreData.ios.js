/**
 * @providesModule RCTCoreData
 * @flow
 */
'use strict';

var React = require('react-native');
var {
  AppStateIOS
} = React;
var NativeRCTCoreData = require('NativeModules').CoreData;
var invariant = require('invariant');

/**
 * High-level docs for the RCTCoreData iOS API can be written here.
 */

var CHANGE = 'change';

var RCTCoreData = {
  load: function() {
    AppStateIOS.addEventListener(CHANGE, this._handleAppStateChange);
  },
  unload: function() {
    AppStateIOS.removeEventListener(CHANGE, this._handleAppStateChange);
  },
  _handleAppStateChange: function(currentAppState) {
    console.log(currentAppState);
  },
  test: function() {
    NativeRCTCoreData.test();
  }
};

module.exports = RCTCoreData;
