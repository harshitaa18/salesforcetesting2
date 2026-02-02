@IsTest
private class DiscountServiceTest {
    @IsTest
    static void applyDiscount_happyPath_updatesAmount() {
        Opportunity opp = new Opportunity(
            Name = 'Big Deal',
            StageName = 'Prospecting',
            Amount = 5000,
            CloseDate = Date.today()
        );
        insert opp;

        Test.startTest();
        Decimal newAmount = DiscountService.applyDiscount(opp.Id);
        Test.stopTest();

        Opportunity updated = [SELECT Amount FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(4500.00, updated.Amount, 'Should apply 10% discount to Amount');
        System.assertEquals(4500.00, newAmount, 'Should return the updated Amount');
    }
}


