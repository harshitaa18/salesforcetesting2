trigger AccountBeforeInsert on Account (before insert) {
    DemoAccountTriggerHandler.beforeInsert(Trigger.new);
}
