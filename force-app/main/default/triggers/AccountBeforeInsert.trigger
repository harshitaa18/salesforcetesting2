trigger AccountBeforeInsert on Account (before insert) {
    DemoAccountTriggerHandler.handleBeforeInsert(Trigger.new);
}