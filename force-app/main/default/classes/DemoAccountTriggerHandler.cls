public with sharing class DemoAccountTriggerHandler {
    public static void beforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            if (String.isBlank(acc.Industry)) {
                acc.Industry = 'Technology';
            }
        }
    }
}
