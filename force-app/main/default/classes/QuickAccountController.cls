public with sharing class QuickAccountController {
    
    @AuraEnabled
    public static Account createAccount(String name, String phone) {
        Account acc = new Account(Name = name, Phone = phone);
        
        // 1. EXECUTE DML FIRST
        insert acc; 

        // 2. UNCOMMITTED WORK PENDING TEST
        // We make an HTTP Callout AFTER a DML statement. 
        // Salesforce will block this, but we wrap it in a try-catch so the UI 
        // test still passes, while the debug log captures the illegal attempt!
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.github.com/zen');
            req.setMethod('GET');
            Http http = new Http();
            HttpResponse res = http.send(req); // Profiler will flag this!
        } catch (Exception e) {
            System.debug('EXPECTED CALLOUT ERROR: ' + e.getMessage());
        }

        // 3. ASYNC JOB TEST
        // Spawn a background job to trigger the "Async Impact" warning
        DemoAccountService.doAsyncStuff(acc.Id);

        return acc;
    }
}