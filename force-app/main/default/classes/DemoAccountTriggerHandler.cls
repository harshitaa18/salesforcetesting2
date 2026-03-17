public with sharing class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            // Artificial Fatal Error for Jataka Testing
            if(acc.Phone == '9999999999'){ // Ensure your test script inputs this phone number!
                acc.addError('STORAGE_LIMIT_EXCEEDED: Simulated fatal database error for Jataka testing.');
            }
        }
    }
}