/*
 * grunt-bbb-server
 * https://github.com/backbone-boilerplate/grunt-bbb-server
 *
 * Copyright 2013 Tim Branyen
 * Licensed under the MIT license.
 */
"use strict";

module.exports = function(grunt) {
  const ENV = process.env;
  const CWD = process.cwd();

  const fs = require("fs");

  grunt.registerMultiTask("server", "Run development server.", function() {
    // Merge defaults and declarative options.
    var options = this.options({
      // Fundamentals.
      favicon: "favicon.ico",
      index: "index.html",

      // Controls how the server is run.
      ssl: ENV.SSL || false,
      host: ENV.HOST || "127.0.0.1",
      port: ENV.PORT || 8000,

      // Register default transpiler mappings.
      transpile: {
        // Script pre-processors.
        ".coffee": require("grunt-lib-coffee").compile,
        ".ts": require("grunt-lib-typescript").compile,

        // Style pre-processors.
        ".styl": require("grunt-lib-stylus").compile,
        ".less": require("grunt-lib-less").compile,
        ".scss": require("grunt-lib-scss").compile,
      },

      // These folders contain physical files that take precendence over the
      // `pushState` redirection.
      folders: fs.readdirSync(CWD).filter(function(file) {
        return fs.statSync(file).isDirectory();
      }),

      // By default use an Express server.
      server: require("express"),
    });
  });

  function run(options) {
    var site = options.server;
  }
};
