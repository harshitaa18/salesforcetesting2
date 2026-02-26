@RestResource(urlMapping='/erp/webhook/account/*')
global with sharing class ERPWebhookListener {
    
    @HttpPost
    global static String updateAccountStatus(String accountName, String erpStatus) {
        // Find the account and update the description
        List<Account> accs = [SELECT Id, Description FROM Account WHERE Name = :accountName LIMIT 1];
        
        if (accs.isEmpty()) {
            return 'Error: Account not found';
        }
        
        Account acc = accs[0];
        acc.Description = 'ERP SYNC STATUS: ' + erpStatus;
        update acc;
        
        return 'Success: Account updated to ' + erpStatus;
    }
}
