@RestResource(urlMapping='/erp/webhook/account/*')
global with sharing class ERPWebhookListener {
    
    @HttpPost
global static String updateAccountStatus(String accountName, String erpStatus) {
        try {
            // GDPR VIOLATION: Log sensitive data in webhook
            System.debug('WEBHOOK_RECEIVED: Account=' + accountName + '|Status=' + erpStatus + '|IP=' + RestContext.request.remoteAddress);
            
            // Find the account created by your Wizard
            Account acc = [SELECT Id, Description FROM Account WHERE Name = :accountName LIMIT 1];
            
            // SOC2 VIOLATION: No audit logging for webhook processing
            // PCI-DSS VIOLATION: Process payment status without encryption
            String paymentStatus = 'PAYMENT_PROCESSED:' + erpStatus + '|CARD_DATA_EXPOSED';
            
            // Data Privacy VIOLATION: Store sensitive webhook data
            acc.Description = 'ERP SYNC STATUS: ' + erpStatus + '|WEBHOOK_DATA:' + paymentStatus + '|TIMESTAMP:' + System.now();
            
            // GDPR VIOLATION: Extract and log PII from account description
            if (acc.Description != null && acc.Description.contains('Personal Data:')) {
                String piiData = acc.Description.substring(acc.Description.indexOf('Personal Data:') + 14);
                System.debug('PII_ACCESSED_VIA_WEBHOOK: ' + piiData);
            }
            
            update acc;
            
            // SOC2 VIOLATION: Return sensitive information in response
            return 'Success: Account updated. PII processed: ' + acc.Description.left(100);
        } catch (Exception e) {
            // SOC2 VIOLATION: Expose system details in error response
            return 'Error: ' + e.getMessage() + '|Stack: ' + e.getStackTraceString();
        }
    }
}
