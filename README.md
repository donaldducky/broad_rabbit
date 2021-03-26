# BroadRabbit

```bash
# bring up rabbitmq
docker-compose up -d rabbitmq
# declare queue
docker-compose exec rabbitmq rabbitmqadmin declare queue name=my_queue durable=true

# pull app deps
mix deps.get

# start app in iex
iex -S mix
```

Check app is running:
```elixir
iex> Application.started_applications() |> Enum.map(&(elem(&1, 0))) |> Enum.find(&(&1 == :broad_rabbit))
:broad_rabbit
```

Kill `ProducerSupervisor`:
```elixir
iex> Process.whereis(BroadRabbit.MyBroadway.Broadway.ProducerSupervisor) |> Process.exit(:kill)
...
14:57:54.967 [info] Application broad_rabbit exited with reason: shutdown
```

App is no longer running:
```elixir
iex> Application.started_applications() |> Enum.map(&(elem(&1, 0))) |> Enum.find(&(&1 == :broad_rabbit))
```

![supervision tree](tree.png)
- killing all of the ✅ has its process restarted
- killing the ❌ processes ends up killing the entire application

I expected them to come back up.

It seems like anything involving the `ProducerSupervisor` causes the app to go down.
