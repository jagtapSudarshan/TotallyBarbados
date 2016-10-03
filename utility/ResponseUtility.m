//
//  ResponseUtility.m
//  TotallyBarbados
//
//  Created by Sudarshan on 6/27/16.
//  Copyright © 2016 Uniken. All rights reserved.
//

#import "ResponseUtility.h"

@implementation ResponseUtility
+(ResponseUtility*)getSharedInstance{
  __strong static ResponseUtility *sharedSessionState = nil;
  static dispatch_once_t onceToken1;
  dispatch_once(&onceToken1, ^{
    sharedSessionState = [[self alloc] init];
    
  });
  return sharedSessionState;
}
@end

//@implementation TrendingCatrgories
//-(id)init:(NSString*)tc_id andCategory_id:(NSString*)category_id andcategory:(NSString*)category andImageName:(NSString*)imageName andImage_url:(NSString*)image_url{
//  self = [super init];
//  if (self) {
//    self.tc_id = tc_id;
//    self.category_id = category_id;
//    self.category = category;
//    self.imageName = imageName;
//    self.image_url = image_url;
//  }
//  return self;
//}
//@end

//@property(nonatomic,strong)NSString *icon;
//@property(nonatomic,strong)NSString *t_id;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *slug;

@implementation TrendingCategories
-(id)init:(NSString*)t_icon andT_id:(NSString*)t_id andName:(NSString*)t_name andSlug:(NSString*)t_slug{
  self = [super init];
  if (self) {
    self.t_icon = t_icon;
    self.t_id = t_id;
    self.t_name = t_name;
    self.t_slug = t_slug;
  }
  return self;
}
@end

@implementation TrendingEvents
-(id)init:(NSString*)te_id andTitle:(NSString*)title andImage_url:(NSString*)image_url andLink:(NSString*)link{
  self = [super init];
  if (self) {
    self.te_id = te_id;
    self.title = title;
    self.image_url = image_url;
    self.link = link;
  }
  return self;
}
@end

@implementation SearchEvents
-(id)init:(NSString*)post_id andVenue:(NSString*)venue andpost_title:(NSString*)post_title andStart_time:(NSString*)start_time andEnd_time:(NSString*)end_time andSearchdate:(NSString*)searchdate andContent:(NSString*)content andPost_date:(NSString*)post_date andAuthor:(NSString*)author andImage:(NSString*)image{
  self = [super init];
  if (self) {
    self.post_id = post_id;
    self.venue = venue;
    self.post_title = post_title;
    self.start_time = start_time;
    self.end_time = end_time;
    self.searchdate = searchdate;
    self.content = content;
    self.post_date = post_date;
    self.author = author;
    self.image = image;
  }
  return self;
}
@end

@implementation Agenda
-(id)init:(NSString*)post_id andVenue:(NSString*)venue andAllday:(NSString*)allday andPost_title:(NSString*)post_title andPost_date:(NSString*)post_date andStart_time:(NSString*)start_time andEnd_time:(NSString*)end_time andAgenda_date:(NSString*)agenda_date{
  self = [super init];
  if (self) {
    self.post_id = post_id;
    self.venue = venue;
    self.allday = allday;
    self.post_title = post_title;
    self.post_date = post_date;
    self.start_time = start_time;
    self.end_time = end_time;
    self.agenda_date = agenda_date;
  }
  return self;
}
@end

@implementation Barbados
-(id)init:(NSString*)post_id andVenue:(NSString*)venue andContact_phone:(NSString*)contact_phone andPost_title:(NSString*)post_title andStart_time:(NSString*)start_time andEnd_time:(NSString*)end_time andBarbados_date:(NSString*)barbados_date andLatitude:(NSString*)lati andLongitude:(NSString*)longi andImage:(NSString*)image andContent:(NSString*)content{
  self = [super init];
  if (self) {
    self.post_id = post_id;
    self.venue = venue;
    self.contact_phone = contact_phone;
    self.post_title = post_title;
    self.start_time = start_time;
    self.end_time = end_time;
    self.barbados_date = barbados_date;
    self.lati = lati;
    self.longi = longi;
    self.image = image;
    self.content = content;
  }
  return self;
}
@end

@implementation PosterBoard
-(id)init:(NSString*)post_id andVenue:(NSString*)venue andPost_title:(NSString*)post_title andStart_time:(NSString*)start_time andEnd_time:(NSString*)end_time andPosterBoard_date:(NSString*)posterBoard_date andImage:(NSString*)image andContent:(NSString*)content{
  self = [super init];
  if (self) {
    self.post_id = post_id;
    self.venue = venue;
    self.post_title = post_title;
    self.start_time = start_time;
    self.end_time = end_time;
    self.posterBoard_date = posterBoard_date;
    self.image = image;
    self.content = content;
  }
  return self;
}
@end

@implementation Stream
-(id)init:(NSString*)post_id andVenue:(NSString*)venue andAllday:(NSString*)allday andPost_title:(NSString*)post_title andStart_time:(NSString*)start_time andEnd_time:(NSString*)end_time andStream_date:(NSString*)stream_date andContent:(NSString*)content andImage:(NSString*)image{
  self = [super init];
  if (self) {
    self.post_id = post_id;
    self.venue = venue;
    self.allday = allday;
    self.post_title = post_title;
    self.start_time = start_time;
    self.end_time = end_time;
    self.stream_date = stream_date;
    self.content = content;
    self.image = image;
  }
  return self;
}
@end

@implementation ViewDetails
-(id)init:(NSString*)venue andAllday:(NSString*)allday andPost_title:(NSString*)post_title andStart_time:(NSString*)start_time andEnd_time:(NSString*)end_time andView_date:(NSString*)view_date andContent:(NSString*)content andImage:(NSString*)image andContact_phone:(NSString*)contact_phone andLati:(NSString*)lati andLongi:(NSString*)longi andContact_email:(NSString*)contact_email andCity:(NSString*)city andAddress:(NSString*)address andCountry:(NSString*)country andPost_date:(NSString*)post_date andPost_author:(NSString*)post_author{
  self = [super init];
  if (self) {

    self.venue = venue;
    self.allday = allday;
    self.post_title = post_title;
    self.start_time = start_time;
    self.end_time = end_time;
    self.view_date = view_date;
    self.content = content;
    self.image = image;
    self.contact_phone = contact_phone;
    self.lati = lati;
    self.longi = longi;
    self.contact_email = contact_email;
    self.city = city;
    self.address = address;
    self.country = country;
    self.post_date = post_date;
    self.post_author = post_author;
  }
  return self;
}
@end

@implementation CategoryDetails



@end