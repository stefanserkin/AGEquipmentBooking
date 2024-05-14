/**************************************************************
 * @description Return an sobject from a collection of sobjects in flow
 * @date 2024
 **************************************************************/
public with sharing class FlowCollectionItemFinder {

    @InvocableMethod(label='Get sObject by Record Id' category='Utilities')
    public static List<Result> getSObjectById(List<Request> lstRequests) {
        List<Result> lstResults = new List<Result>();

        for (Request req : lstRequests) {
            // Prepare response
            Result result = new Result();
            
            // Get item from collection
            Map<Id, SObject> mapSObjects = new Map<Id, SObject>(req.collection);
            if (mapSObjects.containsKey(req.recordId)) {
                result.record = mapSObjects.get(req.recordId);
            }
            lstResults.add(result);
        }

        return lstResults;
    }

    public class Request {
        @InvocableVariable(label='Collection')
        public List<SObject> collection;

        @InvocableVariable(label='Record Id')
        public Id recordId;
    }

    public class Result {
        @InvocableVariable(label='Record')
        public SObject record;
    }
}