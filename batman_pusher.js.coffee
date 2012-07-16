( ->
  Batmanpusher = (channel) ->
    @channel = channel

    @channel.bind "created", (pushed_model) =>
      console?.log('created' + JSON.stringify(pushed_model))
      model = window.App[pushed_model.model_name]
      data = pushed_model.model_data
      foo = new model()
      foo._withoutDirtyTracking -> foo.fromJSON(data)
      model._mapIdentity(foo)

    @channel.bind "updated", (pushed_model) =>
      console?.log('updated' + JSON.stringify(pushed_model))
      model = window.App[pushed_model.model_name]
      data = pushed_model.model_data
      foo = new model()
      foo._withoutDirtyTracking -> foo.fromJSON(data)
      model._mapIdentity(foo)

    @channel.bind "destroyed", (pushed_model) =>
      console?.log('destroyed' + JSON.stringify(pushed_model))
      model = window.App[pushed_model.model_name]
      data = pushed_model.model_data

      foo = new model()
      foo._withoutDirtyTracking -> foo.fromJSON(data)
      existing = model.get('loaded.indexedBy.id').get(foo.get('id'))
      if existing
        model.get('loaded').remove(existing._storage[0])

  @Batmanpusher = Batmanpusher
).call this