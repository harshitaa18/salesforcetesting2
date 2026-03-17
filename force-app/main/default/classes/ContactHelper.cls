public with sharing class ContactHelper {
    public static void dummyMethod(List<Contact> contacts) {
        // Jataka Impact Analysis Test
        for(Contact c : contacts) {
            System.debug('Processing Contact: ' + c.LastName);
        }
    }
}