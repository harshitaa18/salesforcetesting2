public with sharing class DemoAccountService {
    @AuraEnabled
    public static void createDemoAccounts(Integer countToCreate) {
        // --- DELIBERATE BAD PRACTICE FOR TESTING PROFILER ---
        
        // 1. DML Inside a Loop (Triggers High DML Usage)
        for (Integer i = 0; i < countToCreate; i++) {
            Account a = new Account(Name = 'Profiler Test ' + i + ' ' + DateTime.now());
            insert a; // <--- BAD: Database operation inside loop
        }

        // 2. SOQL Inside a Loop (Triggers High SOQL Usage)
        List<Account> check = new List<Account>();
        for (Integer i = 0; i < countToCreate; i++) {
            // <--- BAD: Query inside loop
            Account acc = [SELECT Id, Name FROM Account WHERE Name LIKE 'Profiler%' LIMIT 1];
            check.add(acc);
        }
    }
}