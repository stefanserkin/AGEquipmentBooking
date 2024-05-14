@IsTest
private class FlowCollectionItemFinder_Test {
    
    @IsTest
    static void testGetSObjectById() {
        List<Account> lstAccounts = TestDataFactory.createOrganizationAccounts(10);
        for (Account acc : lstAccounts) {
            acc.Id = TestUtility.getFakeId(Account.SObjectType);
        }

        Account accToFind = lstAccounts[1];

        FlowCollectionItemFinder.Request request = new FlowCollectionItemFinder.Request();
        request.collection = lstAccounts;
        request.recordId = accToFind.Id;

        Test.startTest();
        List<FlowCollectionItemFinder.Result> results = FlowCollectionItemFinder.getSObjectById(
            new List<FlowCollectionItemFinder.Request>{ request }
        );
        Test.stopTest();

        Assert.areEqual(accToFind, results[0].record, 'Received incorrect account record');
    }

    @IsTest
    static void testRecordNotFound() {
        List<Account> lstAccounts = TestDataFactory.createOrganizationAccounts(10);
        for (Account acc : lstAccounts) {
            acc.Id = TestUtility.getFakeId(Account.SObjectType);
        }

        // Create additional account that is not in the collection
        Account accToFind = TestDataFactory.createOrganizationAccounts(1).get(0);
        accToFind.Id = TestUtility.getFakeId(Account.SObjectType);

        FlowCollectionItemFinder.Request request = new FlowCollectionItemFinder.Request();
        request.collection = lstAccounts;
        request.recordId = accToFind.Id;

        Test.startTest();
        List<FlowCollectionItemFinder.Result> results = FlowCollectionItemFinder.getSObjectById(
            new List<FlowCollectionItemFinder.Request>{ request }
        );
        Test.stopTest();

        Assert.isNull(results[0].record, 'Should have received a null value for the returned record');
    }

}