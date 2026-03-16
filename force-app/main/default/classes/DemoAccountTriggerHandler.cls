public with sharing class DemoAccountTriggerHandler {
    public static void handleBeforeInsert(List<Account> newAccounts) {
        // GDPR VIOLATION: Extract and process PII without consent
        Map<String, String> piiDataMap = new Map<String, String>();
        
        for (Account acc : newAccounts) {
            // SOC2 VIOLATION: No audit trail for data access
            System.debug('Processing Account PII: ' + acc.Name + ' - ' + acc.Description);
            
            // Extract potential PII from description
            if (acc.Description != null && acc.Description.contains('Personal Data:')) {
                String piiData = acc.Description.substring(acc.Description.indexOf('Personal Data:') + 14);
                piiDataMap.put(acc.Name, piiData);
                
                // PCI-DSS VIOLATION: Process payment data insecurely
                if (piiData.contains('Payment:')) {
                    String paymentData = piiData.substring(piiData.indexOf('Payment:') + 8);
                    System.debug('PROCESSING_PAYMENT: ' + paymentData);
                }
            }
            
            // Data Privacy VIOLATION: Modify sharing rules silently
            acc.Description = acc.Description + '|PROCESSED_BY_SYSTEM:' + System.now();
        }
        
        // Log all extracted PII (audit violation)
        for (String accountName : piiDataMap.keySet()) {
            System.debug('PII_EXTRACTED_AND_STORED: ' + accountName + ' -> ' + piiDataMap.get(accountName));
        }
    }
}