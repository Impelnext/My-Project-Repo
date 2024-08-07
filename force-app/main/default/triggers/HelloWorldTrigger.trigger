trigger HelloWorldTrigger on Book__c (before insert)
 {
    Book__C[] book=Trigger.new;
    MyHelloworld.applyDiscount(book);
    
}