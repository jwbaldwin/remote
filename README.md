# Remote

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To manually run seeds (also run during `mix ecto.setup`):
  * Run command `mix run remote.db.seeds`

## Api

To view all routes run: `mix phx.routes`

```
    user_path  GET  /                       RemoteWeb.UserController :index
```

Calling this endpoints at `localhost:4000/` yeilds the result:

```
{
  "users":[{"id":999885,"points":84},{"id":999886,"points":98}], 
  "timestamp":"2021-10-12T01:57:09Z"
}
```


## Livebook Notebooks
I created a [Livebook](https://github.com/elixir-nx/livebook) notebook to document the api logic as well as the GenServer logic!
These notebooks can be opened them with Livebook, and follow [this guide](https://fly.io/blog/livebook-for-app-documentation/) from fly.io to run this notebook within the context of the appliction.

You will find it in the notebook folder.

To evaluate the entire notebook in one go, use the command `ea`

## Production
Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
