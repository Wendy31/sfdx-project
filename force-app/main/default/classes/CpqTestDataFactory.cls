@isTest
public class CpqTestDataFactory {
    // create one account with a contact and an opp
    public static Account accWithContactAndOpp() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact con = new Contact(LastName = 'Test User', AccountId = acc.Id);
        insert con;

        Opportuntiy opp = new Opportunity(
            Name = acc.Name + '\'s Opp',
            StageName = 'Negotiation',
            CloseDate = System.today().addMonths(1),
            AccountId = acc.Id
        );
        insert opp;

        return acc;
    }

    // create pricebook standard and USA
    public static List<Pricebook> createPricebooks() {
        Pricebook2 pb = new Pricebook2(Name = 'Pricebook USA', CurrencyIsoCode = 'USD', isActive = true);
        insert pb;
        return pb;
    }

    // create products
    public static List<Product2> createProducts(Integer numProd, String productType, String genericType) {
        // param: numProd, productType, genericType
        // productType: Base Machine, Option (ST), Att, Warranty, Generic
        List<Product2> prodList = new List<Product2>();
        for (Integer i = 0; i < numProd; i++) {
            Product2 prod = new Product2();
            prod.IsActive = true;
            prod.CurrencyIsoCode = 'USD';
            if (productType == 'Base Machine') {
                prod.isGeneric__c = false;
                prod.Name = 'Base Machine';
                prod.Description = 'Base Machine Description';
                prod.ProductType__c = productType;
                prod.Family = 'Base';
                prod.Model__c = 'Base Model';
                prod.ProductCode = 'EC501';
            } else if (productType == 'ATT' || productType == 'Optional') {
                prod.isGeneric__c = false;
                prod.Name = 'ATT/ OPT Machine';
                prod.Description = 'ATT/ OPT Machine Description';
                prod.ProductType__c = productType;
                prod.Family = productType == 'ATT' ? 'Buckets' : 'Undercarriage';
                prod.Model__c = 'Base Model';
                prod.ProductCode = 'EC501';
            } else if (productType == 'Generic') {
                prod.isGeneric__c = true;
                genericType = genericType == 'Family ATT' ? 'Type Attach' : 'Type Others';
                prod.Name = genericType;
                prod.Description = genericType + ' Description';
                prod.ProductType__c = genericType;
                prod.Family = genericType;
                prod.Model__c = 'Base Model';
                prod.ProductCode = 'XC ' + genericType;
            }
            prodList.add(prod);
        }
        return prodList;
    }

    // create PBEs
    public static List<PricebookEntry> createPricebookEntries(Pricebook2 pb, List<Product2> products) {
        // for each product create PBE and set pricebook id and product id
        // mandatory fields: isActive, UnitPrice, CurrencyIsoCode
        // add to list, insert and return
        //PricebookEntry pbe = PricebookEntry(Pricebook2Id = pb.Id, );
        String pricebookId = pb == null ? Test.getStandardPricebookId() : pb.Id;
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        for (Product2 prod : products) {
            PricebookEntry pbe = new PricebookEntry();
            pbe.Product2Id = prod.Id;
            pbe.Pricebook2Id = pricebookId;
            pbe.IsActive = true;
            pbe.UnitPrice = 0;
            pbe.CurrencyIsoCode = 'USD';
            pbeList.add(pbe);
        }
        insert pbeList;
    }

    // create quote
    public static Quote createQuote(String pricebookId, String oppId) {
        Quote quote = new Quote();
        quote.Pricebook2Id = pricebookId;
        quote.OpportunityId = oppId;
        quote.Name = 'VOLVO EC300EL EXCAVATOR - 12\' Arm STANDARD_WENDY TEST CO-_WENDY TEST CO';
        quote.Additional_Equipment__c = 'Print with Price';
        quote.Attachments__c = 'Print with Price';
        quote.Base_Unit__c = 'Print with Price';
        quote.External_Comments__c = 'ABC';
        quote.FinanceMiscellaneous__c = 'Print with Price';
        quote.Options__c = 'Print';
        quote.OthersMiscellaneous__c = 'Print with Price';
        quote.Personal_Letter_Print_Option__c = 'Print';
        quote.ServiceMicellaneous__c = 'Print with Price';
        quote.Trade_In__c = 'Print with Price';
        quote.WarrantyMiscellaneous__c = 'Print with Price';
        insert quote;
    }

    // create QLIs
    public static List<QuoteLineItems> createQuoteLineItems(Quote q, List<PricebookEntry> pbes) {
        Map<String, String> sectionNameMap = new Map<String, Sting>{
            'Attachment' => 'ATT',
            'Option' => 'ST',
            'Finance' => 'Finance',
            'Service' => 'Service',
            'Others' => 'Others',
            'Warranty' => 'Warranty'
        };
        List<QuoteLineItems> qliList = new List<QuoteLineItems>();
        for (PricebookEntry pbe : pbes) {
            QuoteLineItems qli = new QuoteLineItems();
            qli.QuoteId = q.Id;
            qli.PricebookEntryId = pbe.Id;
            qli.Quantity = 1;
            qli.Cost__c = generateRandomNumber(1000, 2000); // create function first
            qli.UnitPrice = qli.Cost__c; //Configurator price displayed
            qli.Customer_Sales_Price__c = qli.Cost__c + 1000;
            qli.IsStandard__c = true;
            qli.IsSelected__c = true;
            qli.Section_Configurator__c = sectionNameMap.get(pbe.Product2.ProductType__c);
            qliList.add(qli);
        }
        insert qliList;
    }
}
