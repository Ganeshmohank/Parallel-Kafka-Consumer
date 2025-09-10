# Parallel Kafka Consumer (Go)

A custom Kafka consumer with built-in concurrency management, written in Go.  
This project is **not** a replacement for Kafka client libraries — instead, it builds on [franz-go](https://github.com/twmb/franz-go) to provide a safer, production-ready consumer experience.  

Inspired by: [confluentinc/parallel-consumer](https://github.com/confluentinc/parallel-consumer)

---

## 🎥 Demo Videos

Watch the key feature demonstrations:

-   🔄 [Rebalance Demo](https://drive.google.com/file/d/1o6VeE-CprLgHEbe2uLJNLv6sFugga7_W/view?usp=drive_link)
    
-   🧹 [Graceful Shutdown & Commit Order](https://drive.google.com/file/d/1UW1iuMDkMZuvPTUWk4MyqiapM1VVc0fO/view?usp=drive_link)
    
-   💥 [Consumer Crash & Reprocessing](https://drive.google.com/file/d/1rn3jfzK_P4RE8eNU3GFrC6L3PZM3uet7/view?usp=drive_link)

### 1. Graceful Shutdown & Offset Commit
Demonstrates how the consumer reacts to termination signals.  
- Stops accepting new messages.  
- Waits until all in-flight processing is finished.  
- Commits processed offsets before exiting.  

### 2. Group Rebalancing in Action
Shows how partition assignments shift when consumers join or leave the group.  
During rebalancing:  
- New message intake is paused.  
- Ongoing tasks complete before partitions are released.  
- Processed offsets are committed before ownership is given up.  
- Once reassigned, partitions resume processing.  

⚠️ Note: Kafka’s `partition.rebalance.timeout.ms` (or `session.timeout.ms`) should be configured to allow enough time for this behavior. Future versions may allow users to choose between waiting for in-flight work or committing only completed offsets.

### 3. Crash Recovery & Message Reprocessing
Illustrates Kafka’s **at-least-once guarantee**.  
- When the consumer crashes, uncommitted messages are reprocessed after restart.  

---

## 🛠 Features

- **Controlled Concurrency**: Global semaphore ensures capped in-flight processing for load balancing.  
- **Graceful Shutdown**: Listens to OS signals, cancels context, waits for workers, and commits offsets safely.  
- **Crash Recovery**: Relies on Kafka semantics to reprocess uncommitted messages after failures.  
- **Rebalance Transparency**: Logs partition assignment, revocation, and reassignment.  
- **Demo Utilities**: Includes producers, viewers, and full demo setup under `demo/`.  

---

## 📁 Usage

See the [`demo/`](./demo) folder and **DEMO.md** for step-by-step instructions on running and testing.  

---

## 🚧 Roadmap

- Retry logic & Dead Letter Queue (DLQ) support  
- Cleaner logs for production clarity  
- Idempotency via distributed cache to prevent duplicate processing after crashes  
- Preserve ordering for messages with identical keys  
- Prometheus metrics for observability  
- Configurable offset commit strategies  
- Refactor to be library-agnostic, enabling multiple Kafka client backends  

---

## 🤝 Contributing

Contributions are encouraged!  

1. Open an issue describing the bug or feature request.  
2. Fork the repo & create a feature branch.  
3. Submit a pull request with clear context.  

For large changes, please start a discussion first.  

Thank you for helping make this project better!
