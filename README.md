Batman Live

Integrating Batman.js and Pusher has a few steps:

*  Server publishes changes to Pusher
*  Pusher sends those to connected clients
*  Batman.js gets Pusher updates and changes in-memory data

The Batman app.js.coffee gets a few lines that have your app key and channel the server publishes on.
```
  @on 'run', ->
    App.pusher = new Pusher("XXXXXXXXXXXXXXXXX")
    channel = App.pusher.subscribe('channel_name')
    pusher = new Batmanpusher(channel)
```

On the backend we use Rails, so it was pretty easy to set up an observer that sends a message to Pusher in the format

```
  def _packaged_model(model)
    package = {}
    package[:model_name] = model.class.to_s
    package[:model_data] = model.as_json
    package
  end
```

Other Comments

*  using _mapIdentity is sub-par since it is a private function (bad!) but that's just for example purposes, using that as an example function would be a good idea for writing your own
*  recommend using something async server side (like Sidekiq for Rails)
*  be mindful of the number of messages you send, for performance reasons