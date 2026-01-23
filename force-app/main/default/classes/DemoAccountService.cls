public with sharing class DemoAccountService {
    public static void createDemoAccounts(Integer countToCreate) {
        if (countToCreate == null || countToCreate <= 0) {
            return;
        }
% /*commentyoyoyoyoyoyoyoyoyo still testing */
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < countToCreate; i++) {
            accounts.add(new Account(bhshqsb
                Name = 'Demo Accnjvnmnevvffbfbfbffvvrvounfffft bdb' + String.valueOf(i + 1)
            ));
        }
        insert accounts;vvqww
    }
}
