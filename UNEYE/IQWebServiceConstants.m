//
//  IQOfflineManagerConstants.m
//  IQOfflineManager
//
//  Copyright (c) 2014 Satya. All rights reserved.
//

#import <Foundation/NSObjCRuntime.h>

@class NSString;

#pragma mark - HTTP Header field constant strings
NSString *const kIQAccept                           =   @"Accept";
NSString *const kIQAcceptCharset                    =   @"Accept-Charset";
NSString *const kIQAcceptDatetime                   =   @"Accept-Datetime";
NSString *const kIQAcceptEncoding                   =   @"Accept-Encoding";
NSString *const kIQAcceptLanguage                   =   @"Accept-Language";
NSString *const kIQAcceptRanges                     =   @"Accept-Ranges";
NSString *const kIQAuthorization                    =   @"Authorization";
NSString *const kIQCacheControl                     =   @"Cache-Control";
NSString *const kIQConnection                       =   @"Connection";
NSString *const kIQContentEncoding                  =   @"Content-Encoding";
NSString *const kIQContentMD5                       =   @"Content-MD5";
NSString *const kIQContentLanguage                  =   @"Content-Language";
NSString *const kIQContentLength                    =   @"Content-Length";
NSString *const kIQContentLocation                  =   @"Content-Location";
NSString *const kIQContentRange                     =   @"Content-Range";
NSString *const kIQContentType                      =   @"Content-Type";
NSString *const kIQCookie                           =   @"Cookie";
NSString *const kIQDate                             =   @"Date";
NSString *const kIQExpires                          =   @"Expires";
NSString *const kIQHost                             =   @"Host";
NSString *const kIQKeepAlive                        =   @"Keep-Alive";
NSString *const kIQLastModified                     =   @"Last-Modified";
NSString *const kIQProxyConnection                  =   @"Proxy-Connection";
NSString *const kIQRange                            =   @"Range";
NSString *const kIQReferer                          =   @"Referer";
NSString *const kIQServer                           =   @"Server";
NSString *const kIQSOAPAction                       =   @"SOAPAction";
NSString *const kIQStatus                           =   @"Status";
NSString *const kIQUserAgent                        =   @"User-Agent";
NSString *const kIQVia                              =   @"Via";
NSString *const kIQXPoweredBy                       =   @"X-Powered-By";


#pragma mark - HTTP Content-Type constant strings
//For Authorization
NSString *const kIQContentTypeAuthorization         =   @"authorization";
//For Multipurpose files
NSString *const kIQContentTypeApplicationJson       =   @"application/json";
NSString *const kIQContentTypeApplicationJavaScript =   @"application/javascript";
NSString *const kIQContentTypeApplicationPdf        =   @"application/pdf";
NSString *const kIQContentTypeApplicationSoapXml    =   @"application/soap+xml";
NSString *const kIQContentTypeApplicationXml        =   @"application/xml";
NSString *const kIQContentTypeApplicationZip        =   @"application/zip";
NSString *const kIQContentTypeApplicationXwwwForm   =   @"application/x-www-form-urlencoded";
//For Audio
NSString *const kIQContentTypeAudioBasic            =   @"audio/basic";
NSString *const kIQContentTypeAudioMp4              =   @"audio/mp4";
NSString *const kIQContentTypeAudioMpeg             =   @"audio/mpeg";
NSString *const kIQContentTypeAudioOgg              =   @"audio/ogg";
//For image
NSString *const kIQContentTypeImageGif              =   @"image/gif";
NSString *const kIQContentTypeImageJpeg             =   @"image/jpeg";
NSString *const kIQContentTypeImagePng              =   @"image/png";
//For message
NSString *const kIQContentTypeMessageHttp           =   @"message/http";
//For multipart
NSString *const kIQContentTypeMultipartMixed        =   @"multipart/mixed";
NSString *const kIQContentTypeMultipartAlternative  =   @"multipart/alternative";
NSString *const kIQContentTypeMultipartRelated      =   @"multipart/related";
NSString *const kIQContentTypeMultipartFormData     =   @"multipart/form-data";
NSString *const kIQContentTypeMultipartEncrypted    =   @"multipart/encrypted";
//For text
NSString *const kIQContentTypeTextCmd               =   @"text/cmd";
NSString *const kIQContentTypeTextCss               =   @"text/css";
NSString *const kIQContentTypeTextCsv               =   @"text/csv";
NSString *const kIQContentTypeTextHtml              =   @"text/html";
NSString *const kIQContentTypeTextJavaScript        =   @"text/javascript";
NSString *const kIQContentTypeTextPlain             =   @"text/plain";
NSString *const kIQContentTypeTextVCard             =   @"text/vcard";
NSString *const kIQContentTypeTextXml               =   @"text/xml";
//For video
NSString *const kIQContentTypeVideoMpeg             =   @"video/mpeg";
NSString *const kIQContentTypeVideoMp4              =   @"video/mp4";
NSString *const kIQContentTypeVideoQuickTime        =   @"video/quicktime";
NSString *const kIQContentTypeVideoWebm             =   @"video/webm";
NSString *const kIQContentTypeVideoXMatroska        =   @"video/x-matroska";
NSString *const kIQContentTypeVideoXMsWmv           =   @"video/x-ms-wmv";
NSString *const kIQContentTypeVideoXFlv             =   @"video/x-flv";
//for charset
NSString *const kIQContentTypeCharsetUtf8           =   @"charset=utf-8";


#pragma mark - HTTP method constant strings
NSString *const kIQHTTPMethodPOST                   =   @"POST";
NSString *const kIQHTTPMethodGET                    =   @"GET";
NSString *const kIQHTTPMethodPUT                    =   @"PUT";
NSString *const kIQHTTPMethodDELETE                 =   @"DELETE";

