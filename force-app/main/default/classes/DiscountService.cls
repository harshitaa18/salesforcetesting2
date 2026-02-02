public with sharing class DiscountService {
    /**
     * Baseline "happy path" discount: apply a global 10% discount to Amountssssssgggdjwjfhgggssjdhqjrgygygrharshitathrtrryfgdhjdgsssss.
     * Used by the discountButton LWC.
     */
    @AuraEnabled
    public static Decimal applyDiscount(Id oppId) {
        if (oppId == null) {
            // Keep it simple + LWC-friendly
            throw new AuraHandledException('Missing Opportunity Id.');
        }

        Opportunity opp = [
            SELECT Id, Amount
            FROM Opportunity
            WHERE Id = :oppId
            LIMIT 1
        ];

        Decimal amount = opp.Amount == null ? 0 : opp.Amount;
        Decimal discounted = (amount * 0.9).setScale(2);
        opp.Amount = discounted;
        update opp;

        return discounted;
    }
}


