public class MyDummyQueueable implements Queueable {
    public void execute(QueueableContext context) {
        // This job does nothing, it's just for the test.
        System.debug('Dummy job executed.');
    }
}
