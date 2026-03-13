trigger AccountBeforeInsert on Account (before insert) {
    /**
     * Account Before Insert Trigger
     * 
     * This trigger fires every time an Account is created before it's committed to the database.
     * It delegates the business logic to the DemoAccountTriggerHandler class.
     * 
     * Purpose: Demonstrate trigger patterns and handler delegation
     * Author: System Demo
     * Date: 2026
     */
    
    // Call the handler method to process the trigger context
    DemoAccountTriggerHandler.handleBeforeInsert(Trigger.new);
}