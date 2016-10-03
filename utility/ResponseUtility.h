//
//  ResponseUtility.h
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseUtility : NSObject
+(ResponseUtility*)getSharedInstance;
@property (nonatomic, strong) NSMutableArray *TrendingCatrgoriesArray;
@property (nonatomic, strong) NSMutableArray *TrendingEventsArray;
@property (nonatomic, strong) NSMutableArray *SearchArray;
@property (nonatomic, strong) NSMutableArray *AgendaArray;
@property (nonatomic, strong) NSMutableArray *BarbadosArray;
@property (nonatomic, strong) NSMutableArray *PosterBoardArray;
@property (nonatomic, strong) NSMutableArray *StreamArray;
@property (nonatomic, strong) NSMutableArray *ViewDetailsArray;
@property (nonatomic, strong) NSMutableArray *CategoryDetailsArray;
@end


//@interface TrendingCatrgories : NSObject
////"id":"1005","category_id":"595","category":"Barbados 50th Anniversary","image":"health.jpg","image_url":"aHR0cDovL2RldmVsb3BkcmVhbXouY29tLm1kLTcwLndlYmhvc3Rib3gubmV0L2JhcmJhZG9zL2NhdGVnb3J5X2ltYWdlL2hlYWx0aC5qcGc="
//@property(nonatomic,strong)NSString *tc_id;
//@property(nonatomic,strong)NSString *category_id;
//@property(nonatomic,strong)NSString *category;
//@property(nonatomic,strong)NSString *imageName;
//@property(nonatomic,strong)NSString *image_url;
//
//@end

@interface TrendingCategories : NSObject
@property(nonatomic,strong)NSString *t_icon;
@property(nonatomic,strong)NSString *t_id;
@property(nonatomic,strong)NSString *t_name;
@property(nonatomic,strong)NSString *t_slug;

@end


@interface TrendingEvents : NSObject
//{"id":"4","title":"RGlhbW9uZHMgSW50ZXJuYXRpb25hbA==","image_url":"aHR0cDovL2RldmVsb3BkcmVhbXouY29tLm1kLTcwLndlYmhvc3Rib3gubmV0L2JhcmJhZG9zL2ltYWdlL2RpYW1vbmQuanBn","link":"https:\/\/www.totallybarbados.com\/barbados\/Local_Listings\/Shopping_Listings\/Jewellery_and_Watch_Listings\/3604.htm"}
@property(nonatomic,strong)NSString *te_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *link;


@end

@interface SearchEvents : NSObject
//{"post_id":"356004","venue":"Carlisle Bay ","post_title":"QmFyYmFkb3MgT3BlbiBXYXRlciBGZXN0aXZhbCAyMDE2","start_time":"01:30 pm","end_time":"09:30 pm","date":"2016-11-02 13:30:00","content":"PHN0cm9uZz5CYXJiYWRvcyBPcGVuIFdhdGVyIEZlc3RpdmFsIDIwMTY8L3N0cm9uZz4NCg0KVGhlIDV0aCBCYXJiYWRvcyBPcGVuIFdhdGVyIEZlc3RpdmFsIHdpbGwgYmUgaGVsZCBpbiBOb3ZlbWJlciAyMDE2Lg0KQ29uZGl0aW9ucyBhcmUgaWRlYWwgZm9yIG9wZW4gd2F0ZXIgc3dpbW1pbmcgaW4gQmFyYmFkb3MgZXNwZWNpYWxseSBhdCB0aGUgdmVudWUgd2hpY2ggaXMgoHRoZSBoaXN0b3JpYyBhbmQgbWFnbmlmaWNlbnQgQ2FybGlzbA==","post_date":"2016-01-20 17:01:01","author":"barbadmin","image":"PGltZyBjbGFzcz0ic2l6ZS1sYXJnZSB3cC1pbWFnZS0zNTYwMDUiIHNyYz0iaHR0cHM6Ly9ldmVudHMudG90YWxseWJhcmJhZG9zLmNvbS93cC1jb250ZW50L3VwbG9hZHMvMjAxNi8wMS9hZXJpYWwtcGhvdG8tc3dzd20tNTAweDI2NC5qcGciIGFsdD0iQmFyYmFkb3MgT3BlbiBXYXRlciBGZXN0aXZhbCAyMDE2IiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjI2NCIgLz4="}
@property(nonatomic,strong)NSString *post_id;
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *searchdate;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *post_date;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *image;

@end

@interface Agenda : NSObject
//{"post_id":"354962","venue":"Bushy Park Race Track","allday":"0","post_title":"U3V6dWtpIFN3aWZ0IERyaXZpbmcgRXhwZXJpZW5jZSBhdCBCdXNoeSBQYXJr","post_date":"2015-11-19 09:19:06","start_time":"12:00 pm","end_time":"09:00 pm","date":"2016-06-27 12:00:00"}
@property(nonatomic,strong)NSString *post_id;
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *allday;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *post_date;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *agenda_date;

@end

@interface Barbados : NSObject
//{"post_id":"354962","venue":"Bushy Park Race Track","contact_phone":"ICgyNDYpIDI1Ni0wMTE0IA==","post_title":"U3V6dWtpIFN3aWZ0IERyaXZpbmcgRXhwZXJpZW5jZSBhdCBCdXNoeSBQYXJr","start_time":"12:00 pm","end_time":"09:00 pm","date":"2016-06-27 12:00:00","latitude":"0.000000000000000","longitude":"0.000000000000000","image":"PGltZyBjbGFz","content":"PHN0cm9uZ"}
@property(nonatomic,strong)NSString *post_id;
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *contact_phone;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *barbados_date;
@property(nonatomic,strong)NSString *lati;
@property(nonatomic,strong)NSString *longi;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *content;

@end

@interface PosterBoard : NSObject
//{"post_id":"354962","venue":"Bushy Park Race Track","post_title":"U3V6dWtpIFN3aWZ0IERyaXZpbmcgRXhwZXJpZW5jZSBhdCBCdXNoeSBQYXJr","start_time":"12:00 pm","end_time":"09:00 pm","date":"2016-06-27 12:00:00","image":"PGltZyBjbGFzcz0ic2l6ZS1mdWx","content":"PHN0cm9uZ"}
@property(nonatomic,strong)NSString *post_id;
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *posterBoard_date;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *content;
@end

@interface Stream : NSObject
//{"post_id":"354962","venue":"Bushy Park Race Track","allday":"0","post_title":"U3V6dWtpIFN3aWZ0IERyaXZpbmcgRXhwZXJpZW5jZSBhdCBCdXNoeSBQYXJr","start_time":"12:00 pm","end_time":"09:00 pm","date":"2016-06-27 12:00:00","content":"PHN0cm9uZz5TdXp1a2kgU3dpZnQgRHJpdmluZyBFeHBlcmllbmNlIGF0IEJ1c2h5IFBhcms8L3N0cm9uZz4NCg0KVGhlIFN1enVraSBTd2lmdCBTcG9ydCBmZWVscyBsaWtlIHRoZSBsYXN0IG9mIGEgZHlpbmcgYnJlZWQgb2YgaG90IGhhdGNoZXMgYW5kIGlzIGEgdHJ1ZSBkcml2ZXJzIGNhci6gVGhlIFN3aWZ0IFNwb3J0IGZlYXR1cmVzIG5hdHVyYWwgYXNwaXJhdGlvbiwg\/GJlciBhZ2lsZSBoYW5kbGluZywgYW5kLCBtb3N0IG9mIGFsbA==","image":"c3JjPSJodHRwczovL2V2ZW50cy50b3RhbGx5YmFyYmFkb3MuY29tL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDE1LzExL1N1enVraS1Ecml2aW5nLUV4cGVyaWVuY2UuanBnIg=="}
@property(nonatomic,strong)NSString *post_id;
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *allday;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *stream_date;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *image;
@end

@interface ViewDetails : NSObject
//[{"venue":"Jolly Roger","allday":"0","post_title":"VWx0aW1hdGUgU25vcmtlbCBUb3VyIHdpdGggQmFyYmFkb3MgQmxhY2sgUGVhcmwgQ3J1aXNlcw==","start_time":"03:00 pm","end_time":"05:00 pm","date":"2014-09-11 15:00:00","content":"PGEgaHJlZj0ia","image":"c3JjPSJo","contact_phone":"KDI0NikgODI2LTcyNDUgb3IgKDI0NikgNDM2LTI4ODU=","latitude":"13.113222000000000","longitude":"-59.598809000000000","contact_email":"bookings@barbadosblackpearl-jollyroger1.com","city":"Bridgetown","address":"Bridgetown, Barbados","country":"Barbados","post_date":"2014-09-11 00:13:58","post_author":"Heidi H."}]
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *allday;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *view_date;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *contact_phone;
@property(nonatomic,strong)NSString *lati;
@property(nonatomic,strong)NSString *longi;
@property(nonatomic,strong)NSString *contact_email;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *post_date;
@property(nonatomic,strong)NSString *post_author;
@end


@interface CategoryDetails : NSObject
//{"post_id":"356004","venue":"Carlisle Bay ","post_title":"QmFyYmFkb3MgT3BlbiBXYXRlciBGZXN0aXZhbCAyMDE2","start_time":"01:30 pm","end_time":"09:30 pm","date":"2016-11-02 13:30:00","content":"PHN0cm9uZz5CYXJiYWRvcyBPcGVuIFdhdGVyIEZlc3RpdmFsIDIwMTY8L3N0cm9uZz4NCg0KVGhlIDV0aCBCYXJiYWRvcyBPcGVuIFdhdGVyIEZlc3RpdmFsIHdpbGwgYmUgaGVsZCBpbiBOb3ZlbWJlciAyMDE2Lg0KQ29uZGl0aW9ucyBhcmUgaWRlYWwgZm9yIG9wZW4gd2F0ZXIgc3dpbW1pbmcgaW4gQmFyYmFkb3MgZXNwZWNpYWxseSBhdCB0aGUgdmVudWUgd2hpY2ggaXMgoHRoZSBoaXN0b3JpYyBhbmQgbWFnbmlmaWNlbnQgQ2FybGlzbA==","post_date":"2016-01-20 17:01:01","author":"barbadmin","image":"PGltZyBjbGFzcz0ic2l6ZS1sYXJnZSB3cC1pbWFnZS0zNTYwMDUiIHNyYz0iaHR0cHM6Ly9ldmVudHMudG90YWxseWJhcmJhZG9zLmNvbS93cC1jb250ZW50L3VwbG9hZHMvMjAxNi8wMS9hZXJpYWwtcGhvdG8tc3dzd20tNTAweDI2NC5qcGciIGFsdD0iQmFyYmFkb3MgT3BlbiBXYXRlciBGZXN0aXZhbCAyMDE2IiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjI2NCIgLz4="}
@property(nonatomic,strong)NSString *post_id;
@property(nonatomic,strong)NSString *venue;
@property(nonatomic,strong)NSString *post_title;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *searchdate;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *post_date;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *image;

@end