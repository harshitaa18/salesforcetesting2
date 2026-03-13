trigger AccountBeforeInsert on Account (before insert) {
    // This fires every time an Account is created
    DemoAccountTriggerHandler.handleBeforeInsert(Trigger.new);
}