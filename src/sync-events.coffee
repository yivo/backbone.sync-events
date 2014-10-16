###
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
###
Backbone.sync = ((previous) ->

  methodToEvent =
    read:     'fetch'
    update:   'save'
    create:   'save'
    patch:    'save'
    'delete': 'destroy'

  (method, model, options) ->
    success = options.success
    error = options.error
    event = methodToEvent[method]

    options.success = (resp) ->
      result = success.apply @, arguments
      return if result is false
      model.trigger.call model, event + ':done', model, resp, options

    options.error = (resp) ->
      result = error.apply @, arguments
      return if result is false
      model.trigger.call model, event + ':error', model, resp, options

    xhr = previous.call @, method, model, options
    model.trigger.call model, event + ':start', model, xhr, options
    xhr

)(Backbone.sync)