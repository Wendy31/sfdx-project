public with sharing class PriceBookEntryController {
    // update UnitPrice to 0,00
    public static void updateUnitPrice() {
        List<PricebookEntry> pbeList = [SELECT Id, UnitPrice FROM PricebookEntry];

        for (PricebookEntry pbe : pbeList) {
            pbe.UnitPrice = 0.0;
        }
        update pbeList;
    }
}
