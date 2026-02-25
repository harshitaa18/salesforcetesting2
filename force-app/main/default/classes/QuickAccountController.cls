public with sharing class QuickAccountController {

    // --- PHASE 4 STEP 1: The Outbound Mock ---
    @AuraEnabled
    public static String fetchErpData(String accountName) {
        // We use a Named Credential so Jataka can swap the URL without changing code
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:MyERP_System/tax-id'); 
        req.setMethod('POST');
        req.setBody('{"name": "' + accountName + '"}');
        req.setTimeout(120000); // Simulate slow network for Async Wait test

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                // Return the mocked ID (e.g., "MOCK-999")
                return res.getBody();
            } else {
                throw new AuraHandledException('ERP Error: ' + res.getStatus());
            }
        } catch (Exception e) {
            // For demo purposes, fallback if Named Credential isn't set up yet
            return 'MOCK-FALLBACK-ID';
        }
    }

    @AuraEnabled
    public static Account createAccount(String name, String phone, String taxId) {
        Account acc = new Account(Name = name, Phone = phone, AccountNumber = taxId);
        
        // --- PHASE 4 STEP 4: The Integration Profiler Trap ---
        // This code works for 1 record, but is bad practice.
        // Jataka's profiler should catch the high SOQL usage if we run a bulk test.
        List<Contact> existingContacts = [SELECT Id FROM Contact WHERE Account.Name = :name];
        
        // Bad Loop Logic (The Governor Limit Trap)
        for(Integer i=0; i<existingContacts.size(); i++) {
             // Useless query inside loop to trigger Jataka's Profiler Warning
             List<Account> temp = [SELECT Id FROM Account LIMIT 1]; 
        }

        insert acc;
        return acc;
    }
}