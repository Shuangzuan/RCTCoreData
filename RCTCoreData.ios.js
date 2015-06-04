/**
 * @providesModule RCTCoreData
 * @flow
 */
'use strict';

var NativeRCTCoreData = require('NativeModules').RCTCoreData;
var invariant = require('invariant');

/**
 * High-level docs for the RCTCoreData iOS API can be written here.
 */

var RCTCoreData = {
  test: function() {
    NativeRCTCoreData.test();
  }
};

module.exports = RCTCoreData;
