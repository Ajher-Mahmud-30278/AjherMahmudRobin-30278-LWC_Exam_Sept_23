public with sharing class AuditForecastController {

    @AuraEnabled(cacheable=True)

    List<Opportunity> oldfilteredOppList = new List<Opportunity>();
    List<Opportunity> oldrecordId = new List<Opportunity>();

    public static List<Opportunity> AuditForecastHandler(List<Opportunity> oldrecordId, List<Opportunity> oldfilteredOppList) {
        Date thisDate = Date.today();
        Date lastDayOfMonth = thisDate.toStartOfMonth().addMonths(1).addDays(-1);
        List<Opportunity> oppList = new List<Opportunity>();
        oppList = [SELECT Id, Name, Amount, Probability, Expected_Revenue_Overridden__c, StageName FROM Opportunity WHERE CloseDate = :lastDayOfMonth WITH USER_MODE];


        // List<Opportunity> filteredOppList = new List<Opportunity>();
        // List<Opportunity> recordId = new List<Opportunity>();

        for(Opportunity opp : oppList){
            if(opp.StageName == 'Proposal/Price Quote' || opp.StageName == 'Negotiation/Review' || opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){

            }
            else {
                oldrecordId.add(opp.Id);
                oldfilteredOppList.add(opp);
            }
            }
                return oldrecordId;
                return oldfilteredOppList;
            }
@AuraEnabled
public static List<Opportunity> setExpectedRevenueLogic(List<Id> recordID, Decimal Amount) {
                  List<Opportunity> recordId = new List<Opportunity>();
                  List<Opportunity> filteredOppList = new List<Opportunity>();
                  for(Opportunity o : filteredOppList){
                    if(o.Amount > $2000000 && o.Probability > 50){
                        o.Expected_Revenue_Overridden__c = Amount * 0.15;
                        }
                    else{
                        o.Expected_Revenue_Overridden__c = Amount * 0.10;
                    }
                        filteredOppList.add(o);
                        recordId.add(o.Id);
                        update o;
                        }
                  return recordId;
                  return filteredOppList;
                  }
                  
                    
        }
