//
//  EncryptDecrypt.h
//  StarPoker
//
//  Created by Wu,Yi(Int'l RD) on 16/9/21.
//
//

#import <Foundation/Foundation.h>

extern int hex2str(const char *hex, int hexlen, char *str);

extern int hex2strUpper(const char *hex, int hexlen, char *str);

extern int str2hex(const char * src_str, char* hex, unsigned max_len);

@interface EncryptDecrypt : NSObject
{

}

+ (instancetype)shareInstance;
+ (NSString*)hex2StrUpper:(NSData*)data;
+ (NSData*)strUpper2hex:(NSString*)str;

- (NSString*)stringEncrypt:(NSString*)rawStr; //加密
- (NSString*)dataDecrypt:(NSData*)rawData;    //解密

@end
