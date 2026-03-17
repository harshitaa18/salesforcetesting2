public with sharing class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            // Logic to be executed before insert
            // Logic to be executed before insert 
            System.debug('Processing Account: ' + acc.Name);
            
            System.debug('testing and testing and testing and testinggg ');
            if(acc.Phone == '9999999999'){
                System.debug('🚨 Alert: Suspicious phone number detected!');
                // We will add a fake SOQL loop here later to test the PR Blocker, 
                // but for now, this simple IF statement will trigger the regression tests!
            }
        }
    }
}