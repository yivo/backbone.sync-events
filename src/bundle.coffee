((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['backbone', 'underscore'], (Backbone, _) ->
      factory Backbone, _
  else if typeof exports isnt 'undefined'
    module.exports = factory require('Backbone'), require('underscore')
  else
    factory root.Backbone, root._
)(@, (Backbone, _) ->
  'use strict'

  # @include sync-events.coffee

)