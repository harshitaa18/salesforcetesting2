public class DummyQueueable implements Queueable {
    public void execute(QueueableContext context) {
        // Do nothing, just take up space in the Async queue
        System.debug('Dummy async job running...');
    }
}
