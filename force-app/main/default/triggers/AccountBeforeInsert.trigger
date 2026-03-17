trigger AccountBeforeInsert on Account (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        
        // JATAKA IMPACT TEST
        if (System.now().hour() == 99) {
            System.debug('This will trigger the Baseline-Account-CRUD test!');
        }

        DemoAccountTriggerHandler.handleBeforeInsert(Trigger.new);
    }
}