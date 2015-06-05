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

var RCTCoreData = {
  add: function(options, callback) {
    NativeRCTCoreData.add(options, callback);
  },
  fetch: function(options, callback) {
    NativeRCTCoreData.fetch(options, callback);
  }
};

module.exports = RCTCoreData;
