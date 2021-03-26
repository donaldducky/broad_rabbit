defmodule BroadRabbit.MySqs do
  use Broadway

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {
          BroadwaySQS.Producer,
          queue_url: System.fetch_env!("SQS_QUEUE"),
          config: [
            # AWS_REGION does not seem to be automatically picked up
            region: System.fetch_env!("AWS_REGION"),
            # NOTE: if AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID is set, it will be used
            # Just leaving these fetch_env! here in case I forget at some point
            secret_access_key: System.fetch_env!("AWS_SECRET_ACCESS_KEY"),
            access_key_id: System.fetch_env!("AWS_ACCESS_KEY_ID")
          ]
        }
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ]
    )
  end

  def handle_message(_, message, _) do
    IO.inspect(message.data, label: "Got message")
    message
  end
end
