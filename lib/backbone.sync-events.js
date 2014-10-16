(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    return define(['backbone', 'underscore'], function(Backbone, _) {
      return factory(Backbone, _);
    });
  } else if (typeof exports !== 'undefined') {
    return module.exports = factory(require('Backbone'), require('underscore'));
  } else {
    return factory(root.Backbone, root._);
  }
})(this, function(Backbone, _) {
  'use strict';

  /*
    Triggers additional events:
      fetch:start
      fetch:done
      fetch:error
      save:start
      save:done
      save:error
      destroy:start
      destroy:done
      destroy:error
   */
  return Backbone.sync = (function(previous) {
    var methodToEvent;
    methodToEvent = {
      read: 'fetch',
      update: 'save',
      create: 'save',
      patch: 'save',
      'delete': 'destroy'
    };
    return function(method, model, options) {
      var error, event, success, xhr;
      success = options.success;
      error = options.error;
      event = methodToEvent[method];
      options.success = function(resp) {
        var result;
        result = success.apply(this, arguments);
        if (result === false) {
          return;
        }
        return model.trigger.call(model, event + ':done', model, resp, options);
      };
      options.error = function(resp) {
        var result;
        result = error.apply(this, arguments);
        if (result === false) {
          return;
        }
        return model.trigger.call(model, event + ':error', model, resp, options);
      };
      xhr = previous.call(this, method, model, options);
      model.trigger.call(model, event + ':start', model, xhr, options);
      return xhr;
    };
  })(Backbone.sync);
});
