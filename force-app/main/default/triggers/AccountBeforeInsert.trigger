trigger AccountBeforeInsert on Account (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        DemoAccountTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    // <-- ADD THIS BLOCK TO TRIGGER THE FAILURE -->
    // This loop intentionally clogs the async queue.
    for (Integer i = 0; i < 50; i++) {
        System.enqueueJob(new MyDummyQueueable());
    }
}