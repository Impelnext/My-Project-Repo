public class linkedlnIntegration {
    public static void postOnLinkedln(String Message){
        String loginId = loginToLinkedln();
        postMessage(loginId,Message);
    }
    public static string loginToLinkedln(){
        Http http = new Http();
        Httprequest request = new Httprequest();
        request.setmethod('GET');
        request.setEndpoint('callout:LInkedln/v2/me');
        
        Httpresponse response = http.send(request);
        //system.debug('Test' + response.getBody());
        //system.debug('Test2' + response.getStatusCode());
        Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        String loginId = (String) result.get('id');
        //system.debug('Test3' + loginId);
        return loginId;
        
    }
    public static void postMessage(String loginId,String postMessage){
        Http http = new Http();
        Httprequest request = new Httprequest();
        request.setMethod('POST');
        request.setHeader('X-Restli-Protocol-Version', '2.0.0');
        request.setHeader('Content-Type', 'application/json');
        string autherId = 'urn:li:person:' + loginId;
        
        string linkedlnPostBody = 
            '{ ' +
    '"author": "'+autherId+'",' +
    '"lifecycleState": "PUBLISHED",' +
   '"specificContent": { ' +
        '"com.linkedin.ugc.ShareContent": { '+
            '"shareCommentary": { ' +
                '"text": "'+postMessage+'" ' +
            ' },' +
           ' "shareMediaCategory": "NONE" ' +
        ' } ' +
    ' },' +
    '"visibility": { ' +
        '"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC" ' +
    ' } ' +
' } ' ;
        
        request.setBody(linkedlnPostBody);
        request.setEndpoint('callout:LInkedln/v2/ugcPosts');
        //Httpresponse response = http.send(request);
        Httpresponse response = http.send(request);
        system.debug('Test99'  +response.getBody());
        system.debug('Test100'  + response.getStatusCode());
    }

}