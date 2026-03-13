public class DemoAccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> newList) {
        for(Account acc : newList) {
            if(acc.Phone != null) {
                // 1. Logic change
                acc.Description = 'Processed by Trigger';
                
                // 2. Performance Trap! 
                // This consumes 1 SOQL query. We want to see if the UI test catches this
                // hittiiiiiiiiiiiing the governor limits in the background.
                List<Contact> dummyCheck = [SELECT Id FROM Contact LIMIT 1];
            }
        }
    }
}