public with sharing class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            // Logic to be executed before insert
            System.debug('Processing Account: ' + acc.Name);
            // JATAKA IMPACT TEST
            if (System.now().hour() == 99) {
                System.debug('Triggering clean baseline test');
            }
        }
    }
}