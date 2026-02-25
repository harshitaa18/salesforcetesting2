public with sharing class QuickAccountController {

    // --- PHASE 4 STEP 1: The Outbouounnnd Mock ---
    @AuraEnabled
    public static String fetchErpData(String accountName) {
        HttpRequest req = new HttpRequest();
        // This will now point to your webhook.site!
        req.setEndpoint('callout:MyERP_System'); 
        req.setMethod('POST');
        req.setBody('{"name": "' + accountName + '"}');
        req.setTimeout(120000); 

        Http http = new Http();
        HttpResponse res = http.send(req); // NO TRY/CATCH! If it fails, let it crash!
        
        if (res.getStatusCode() == 200) {
            return res.getBody();
        } else {
            throw new AuraHandledException('ERP Error: ' + res.getStatus());
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