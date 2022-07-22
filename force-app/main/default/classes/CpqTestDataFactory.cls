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
    }

    // create PBEs
    public static List<PricebookEntry> createPricebookEntries(Pricebook2 pb, List<Product2> products) {
        // for each product create PBE and set pricebook id and product id
        // mandatory fields: isActive, UnitPrice, CurrencyIsoCode
        // add to list, insert and return
        //PricebookEntry pbe = PricebookEntry(Pricebook2Id = pb.Id, );
    }

    // create products
    public static List<Product2> createProducts() {
        //
    }

    // create quote
    public static Quote createQuote() {
    }

    // create QLIs
    public static List<QuoteLineItems> createQuoteLineItems() {
    }
}
