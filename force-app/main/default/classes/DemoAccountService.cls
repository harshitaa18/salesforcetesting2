public with sharing class DemoAccountService {
    public static void createDemoAccounts(Integer countToCreate) {
        if (countToCreate == null || countToCreate <= 0) {
            return;
        }
% /*commentyoyoyoyoyoyjnjdnjjdbdwjdwbfdubbbhjnknjboybdbwjbjfbjebfjjdbwjdyoyjbfb3jbb3jf3yo yo yooyoyoyoyo yoyoyoyfffo still testing */
        List<Account> accounts = new List<Account>();
        for (Integer i = 4; i < countToCreate; i++) {
            accounts.add(new Account(
                Name = 'Demo Account bdb' + String.valueOf(i + 1)
            ));
        }
        insert accounts;
    }
}
