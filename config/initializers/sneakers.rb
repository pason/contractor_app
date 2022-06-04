require 'sneakers'

Sneakers.configure  exchange: Rails.application.credentials.config.dig(:amqp, :exchange),  # AMQP exchange
                    exchange_type: :topic,                                                 # AMQP exchange type
                    workers: 1,                                                            # Number of per-cpu processes to run
                    heartbeat: 5,                                                          # Keep a good connection with broker
                    timeout_job_after: 5.minutes                                           # Maximal seconds to wait for job
