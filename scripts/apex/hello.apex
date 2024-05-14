// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<Case> lstCases = [
    SELECT Id, CaseNumber FROM Case LIMIT 20
];

Id recordId = lstCases[4].Id;

FlowCollectionItemFinder.Request request = new FlowCollectionItemFinder.Request();
request.collection = lstCases;
request.recordId = recordId;
List<FlowCollectionItemFinder.Request> lstRequests = new List<FlowCollectionItemFinder.Request>();
lstRequests.add(request);

List<FlowCollectionItemFinder.Result> lstResults;
lstResults = FlowCollectionItemFinder.getSObjectById(lstRequests);
System.assertEquals(recordId, lstResults[0].record.Id);