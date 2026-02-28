public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        System.debug('Starting Account Creation for: ' + name);

        // 1. METRIC GENERATOR: SOQL Query
        // Check if account exists to prevent duplicates
        List<Account> duplicates = [SELECT Id FROM Account WHERE Name = :name LIMIT 1];
        
        if (!duplicates.isEmpty()) {
            throw new AuraHandledException('Error: An Account with this name already exists.');
        }

        // 2. METRIC GENERATOR: DML Statement (1 of 2)
        Account newAcc = new Account();
        newAcc.Name = name;
        newAcc.Phone = phone;
        insert newAcc;
        System.debug('Account inserted: ' + newAcc.Id);

        // 3. METRIC GENERATOR: DML Statement (2 of 2)
        // Create a follow-up task
        Task newTask = new Task();
        newTask.Subject = 'Welcome Call';
        newTask.WhatId = newAcc.Id;
        newTask.Status = 'Not Started';
        newTask.Priority = 'Normal';
        insert newTask;
        System.debug('Onboarding Task inserted');

        return newAcc;
    }
}