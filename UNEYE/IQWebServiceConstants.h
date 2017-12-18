//
//  IQOfflineManagerConstants.h
//  IQOfflineManager
//
//  Copyright (c) 2014 Satya. All rights reserved.
//

@class UIImage, NSURLResponse, NSError, NSString, NSData;

#pragma mark - Completion blocks
/*! @abstract Downloadeded NSData will return through IQCompletionBlock */
typedef void (^IQCompletionBlock)(NSData *data, NSURLResponse *response, NSError *error);

#pragma mark - HTTP Header field constant strings
/*! @abstract @"Accept"  */
extern NSString *const kIQAccept;
/*! @abstract @"Accept-Charset"  */
extern NSString *const kIQAcceptCharset;
/*! @abstract @"Accept-Datetime"  */
extern NSString *const kIQAcceptDatetime;
/*! @abstract @"Accept-Encoding"  */
extern NSString *const kIQAcceptEncoding;
/*! @abstract @"Accept-Language"  */
extern NSString *const kIQAcceptLanguage;
/*! @abstract @"Accept-Ranges"  */
extern NSString *const kIQAcceptRanges;
/*! @abstract @"Authorization"  */
extern NSString *const kIQAuthorization;
/*! @abstract @"Cache-Control"  */
extern NSString *const kIQCacheControl;
/*! @abstract @"Connection"  */
extern NSString *const kIQConnection;
/*! @abstract @"Content-Encoding"  */
extern NSString *const kIQContentEncoding ;
/*! @abstract @"Content-MD5"  */
extern NSString *const kIQContentMD5;
/*! @abstract @"Content-Language"  */
extern NSString *const kIQContentLanguage;
/*! @abstract @"Content-Length"  */
extern NSString *const kIQContentLength;
/*! @abstract @"Content-Location"  */
extern NSString *const kIQContentLocation;
/*! @abstract @"Content-Range"  */
extern NSString *const kIQContentRange;
/*! @abstract @"Content-Type"  */
extern NSString *const kIQContentType;
/*! @abstract @"Cookie"  */
extern NSString *const kIQCookie;
/*! @abstract @"Date"  */
extern NSString *const kIQDate;
/*! @abstract @"Expires"  */
extern NSString *const kIQExpires;
/*! @abstract @"Host"  */
extern NSString *const kIQHost;
/*! @abstract @"@"Keep-Alive""  */
extern NSString *const kIQKeepAlive;
/*! @abstract @"Last-Modified"  */
extern NSString *const kIQLastModified;
/*! @abstract @"Proxy-Connection"  */
extern NSString *const kIQProxyConnection;
/*! @abstract @"Range"  */
extern NSString *const kIQRange;
/*! @abstract @"Referer"  */
extern NSString *const kIQReferer;
/*! @abstract @"Server"  */
extern NSString *const kIQServer;
/*! @abstract @"SOAPAction"  */
extern NSString *const kIQSOAPAction;
/*! @abstract @"Status"  */
extern NSString *const kIQStatus;
/*! @abstract @"User-Agent"  */
extern NSString *const kIQUserAgent;
/*! @abstract @"Via"  */
extern NSString *const kIQVia;
/*! @abstract @"X-Powered-By"  */
extern NSString *const kIQXPoweredBy;


#pragma mark - HTTP method constant strings
/*! @abstract @"POST"  */
extern NSString *const kIQHTTPMethodPOST;
/*! @abstract @"GET"  */
extern NSString *const kIQHTTPMethodGET;
/*! @abstract @"PUT"  */
extern NSString *const kIQHTTPMethodPUT;
/*! @abstract @"DELETE"  */
extern NSString *const kIQHTTPMethodDELETE;


#pragma mark - HTTP Content-Type constant strings
//For Authorization
extern NSString *const kIQContentTypeAuthorization;
//For Multipurpose files
/*! @abstract @"application/json"  */
extern NSString *const kIQContentTypeApplicationJson;
/*! @abstract @"application/javascript"  */
extern NSString *const kIQContentTypeApplicationJavaScript;
/*! @abstract @"application/pdf"  */
extern NSString *const kIQContentTypeApplicationPdf;
/*! @abstract @"application/soap+xml"  */
extern NSString *const kIQContentTypeApplicationSoapXml;
/*! @abstract @"application/xml"  */
extern NSString *const kIQContentTypeApplicationXml;
/*! @abstract @"application/zip"  */
extern NSString *const kIQContentTypeApplicationZip;
/*! @abstract @"application/x-www-form-urlencoded"  */
extern NSString *const kIQContentTypeApplicationXwwwForm;
//For Audio
/*! @abstract @"audio/basic"  */
extern NSString *const kIQContentTypeAudioBasic;
/*! @abstract @"audio/mp4"  */
extern NSString *const kIQContentTypeAudioMp4;
/*! @abstract @"audio/mpeg"  */
extern NSString *const kIQContentTypeAudioMpeg;
/*! @abstract @"audio/ogg"  */
extern NSString *const kIQContentTypeAudioOgg;
//For image
/*! @abstract @"image/gif"  */
extern NSString *const kIQContentTypeImageGif;
/*! @abstract @"image/jpeg"  */
extern NSString *const kIQContentTypeImageJpeg;
/*! @abstract @"image/png"  */
extern NSString *const kIQContentTypeImagePng;
//For message
/*! @abstract @"message/http"  */
extern NSString *const kIQContentTypeMessageHttp;
//For multipart
/*! @abstract @"multipart/mixed"  */
extern NSString *const kIQContentTypeMultipartMixed;
/*! @abstract @"multipart/alternative"  */
extern NSString *const kIQContentTypeMultipartAlternative;
/*! @abstract @"multipart/related"  */
extern NSString *const kIQContentTypeMultipartRelated;
/*! @abstract @"multipart/form-data"  */
extern NSString *const kIQContentTypeMultipartFormData;
/*! @abstract @"multipart/encrypted"  */
extern NSString *const kIQContentTypeMultipartEncrypted;
//For text
/*! @abstract @"text/cmd"  */
extern NSString *const kIQContentTypeTextCmd;
/*! @abstract @"text/css"  */
extern NSString *const kIQContentTypeTextCss;
/*! @abstract @"text/csv"  */
extern NSString *const kIQContentTypeTextCsv;
/*! @abstract @"text/html"  */
extern NSString *const kIQContentTypeTextHtml;
/*! @abstract @"text/javascript"  */
extern NSString *const kIQContentTypeTextJavaScript;
/*! @abstract @"text/plain"  */
extern NSString *const kIQContentTypeTextPlain;
/*! @abstract @"text/vcard"  */
extern NSString *const kIQContentTypeTextVCard;
/*! @abstract @"text/xml"  */
extern NSString *const kIQContentTypeTextXml;
//For video
/*! @abstract @"video/mpeg"  */
extern NSString *const kIQContentTypeVideoMpeg;
/*! @abstract @"video/mp4"  */
extern NSString *const kIQContentTypeVideoMp4;
/*! @abstract @"video/quicktime"  */
extern NSString *const kIQContentTypeVideoQuickTime;
/*! @abstract @"video/webm"  */
extern NSString *const kIQContentTypeVideoWebm;
/*! @abstract @"video/x-matroska"  */
extern NSString *const kIQContentTypeVideoXMatroska;
/*! @abstract @"video/x-ms-wmv"  */
extern NSString *const kIQContentTypeVideoXMsWmv;
/*! @abstract @"video/x-flv"  */
extern NSString *const kIQContentTypeVideoXFlv;
//For Charset
/*! @abstract @"charset=utf-8"  */
extern NSString *const kIQContentTypeCharsetUtf8;
