public with sharing class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            System.debug('Processing Account: ' + acc.Name);

            // Artificial Fatal Error for Jataka Healer Testing
            if (acc.Phone == '999999999') {
                System.debug(':rotating_light: Alert: Suspicious phone number detected!');
                // Throw an uncatchable exception to trigger a red popup on the UI
                acc.addError('STORAGE_LIMIT_EXCEEDED: Simulated fatal database error for Jataka testing.');
            }
        }
    }
}