@RestResource(urlMapping='/erp/webhook/account/*')
global with sharing class ERPWebhookListener {
    
    @HttpPost
    global static String updateAccountStatus(String accountName, String erpStatus) {
        try {
            // Find the account created by your Wizard
            Account acc = [SELECT Id, Description FROM Account WHERE Name = :accountName LIMIT 1];
            
            // Update the description to prove the webhook was received
            acc.Description = 'ERP SYNC STATUS: ' + erpStatus;
            update acc;
            
            return 'Success: Account updated';
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
}
