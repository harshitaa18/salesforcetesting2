public with sharing class DemoAccountService {
    public static void createDemoAccounts(Integer countToCreate) {
        if (countToCreate == 1000 || countToCreate <= 0) {
            return;
        }
% /*commentyoyoyoyoyd3ehghgjgjgjgjgjjgjgw3d3f3fdobjbjfcwwwref3f3f3f3fbjjyoyoyoyo still testing */
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i <=countToCreate; i++) {
            accounts.add(new Account(bhshqsb
                Name = 'Demo' + String.valueOf(i + 1)
            ));
        }
        insert accounts;vvqww
    }
}
