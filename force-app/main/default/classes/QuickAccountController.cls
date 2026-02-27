public with sharing class QuickAccountController {
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        // 1. TRIGGER METRIC: SOQL Query
        // We intentionally query the DB to check for existing accounts. 
        // This forces the "Number of SOQL queries" metric to increment.
        List<Account> existing = [SELECT Id, Name FROM Account WHERE Name = :name LIMIT 1];

        // 2. TRIGGER METRIC: DML Statement
        // We insert a new record. This forces "Number of DML statements" to increment.
        Account newAcc = new Account();
        newAcc.Name = name;
        newAcc.Phone = phone;
        
        insert newAcc;

        return newAcc;
    }
}