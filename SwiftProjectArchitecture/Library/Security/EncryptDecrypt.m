//
//  EncryptDecrypt.m
//  StarPoker
//
//  Created by Wu,Yi(Int'l RD) on 16/9/21.
//
//

#import "EncryptDecrypt.h"
#import "GTMBase64.h"
#import "NSData+CommonCrypto.h"

#define AESKEY_LENGTH 32

#define RSA_Public_key         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8rPqGGsar+BWI7vAtaaDOqphy41j5186hCU9DcchV4HWiv0HvQ3KXAEqHfZiAHZSyMSRMmDZVnqJwCVWFvKUPqU1RsCPZ9Imk+9ZXVkM3DDdw74v/s6YMNx8cTuxybRCJUfOKbyC79cnHgmQqqkODv+EnprBtNKE4k8g90jNmbwIDAQAB"

#define RSA_Private_Key @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALt5UGaod0s+mJq2PuqvTSumF6IDgQwGSbQLDXjDVgCl8Lyn7KulkGwtlFdqzk7iW0O1QntN/73D63FQUn3J2hUGUlLnu1XNh2aOVAgNy+SWP0RweC4k8gzi+6Pf4cItinvT3SKF/vfBDZybBR9JOlM0USC0y3d7xtR6Eyb7/XB7AgMBAAECgYBUMU8iS1YHvLzb/iyTSNbnW1gRsnEp7Uj8SlpqeY8OC3fpwaBQFbKeYnnUKGsukglahvSsW4MWvf3mjaP+ScBeGqCFcOrgqW7eA59lmZwPJ91HNRHZqZiF10JBo34pToB6ZQSyur0+byrTTQntiaqoYkzQl7TH2mel9PWZrNgWgQJBAPb+yl6MLn3Z6VcizCnhMH+Tq+5jv991/lq60qb/3F9nkx616CIuoMu2DzyeoAhl0Moupv1I5XDb1n9Xu3cVJlkCQQDCTwKBHBLitoo0x4Zn+RnJUuJRA4hns3NcjbMuclAFBdCnPop8cmQSRy2xFyYVr6584I3bXmP8K6Hy+jJejRrzAkEAgpmUrcuXpan8jLt0ksxklYCiz4lk4iaE2LqiOfVeNAATNZDf7nsTQMPCaL5DRk13ygBDAfhygWtsjqb4E+5V+QJBAJWdvuDpXAVj5xFy3SRsI5Xok0ksPjkTbW3D0keeT80+SAavWnUuo62LTzyABZxHNUUEp1ZV3QlME5yDWIuDfU8CQQDctsKjWkhXCacbs4lCBC8gDQMta3uoO65QR14AraTALdDCuyqO8gZP8wbeZT4fzdTZ/4NsPCIyxmaCZAPfXkHZ"

#define ServerAESKey @"FAC9A338B21B47B1"
#define ClientAESKey @"626BF5049DD64849"

int hex2str(const char *hex, int hexlen, char *str)
{
    unsigned char c, s;
    int i = 0;
    
    while(hexlen > 0)
    {
        c = *hex++;
        hexlen--;
        
        s = 0x0F & c;
        if ( s < 10 )
        {
            str[i + 1] = '0' + s;
        }
        else
        {
            str[i + 1] = 'a' + (s - 10);
        }
        
        c >>= 4;
        s = 0x0F & c;
        if ( s < 10 )
        {
            str[i] = '0' + s;
        }
        else
        {
            str[i] = 'a' + (s - 10);
        }
        i += 2;
    }
    str[i++] = '\0';
    return i;
}

int hex2strUpper(const char *hex, int hexlen, char *str)
{
    unsigned char c, s;
    int i = 0;
    
    while(hexlen > 0)
    {
        c = *hex++;
        hexlen--;
        
        s = 0x0F & c;
        if ( s < 10 )
        {
            str[i + 1] = '0' + s;
        }
        else
        {
            str[i + 1] = 'A' + (s - 10);
        }
        
        c >>= 4;
        s = 0x0F & c;
        if ( s < 10 )
        {
            str[i] = '0' + s;
        }
        else
        {
            str[i] = 'A' + (s - 10);
        }
        i += 2;
    }
    str[i++] = '\0';
    return i;
}

int str2hex(const char * src_str, char* hex, unsigned max_len)
{
    char c, s;
    int i = 0;
    while(*src_str)
    {
        s = 0x20 | (*src_str++);
        if(s >= '0' && s <= '9')
            c = s - '0';
        else if(s >= 'a' && s <= 'f')
            c = s - 'a' + 10;
        else
            break;
        
        c <<= 4;
        s = 0x20 | (*src_str++);
        if(s >= '0' && s <= '9')
            c += s - '0';
        else if(s >= 'a' && s <= 'f')
            c += s - 'a' + 10;
        else
            break;
        
        hex[i++] = c;
        
        if(max_len != 0 && i == max_len)
            break;
    }
    return i;
}

@implementation EncryptDecrypt

+ (instancetype)shareInstance
{
    static EncryptDecrypt *_encryptDecrypt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _encryptDecrypt = [[self alloc] init];
    });
    return _encryptDecrypt;
}

+(NSString*)hex2StrUpper:(NSData*)data
{
    const char* hexString = (const char*)[data bytes];
    int len = (int)data.length;
    char* ch = malloc(((len << 1) + 1)*sizeof(char));
    hex2strUpper(hexString, len, ch);
    NSString* str = [NSString stringWithCString:ch encoding:NSUTF8StringEncoding];
    free(ch);
    return str;
}

+ (NSData*)strUpper2hex:(NSString*)str
{
    int length = (int)[str length];
    char* dstChar = malloc((length+1)*sizeof(char));
    int dstLength = str2hex([str.lowercaseString UTF8String], dstChar, (length+1)*sizeof(char));
    NSData* retData = [NSData dataWithBytes:dstChar length:dstLength];
    free(dstChar);
    return retData;
}

- (NSData*)encodeBCD:(NSString*)bcdstr
{
    int leng = (int)bcdstr.length/2;
    if (bcdstr.length%2 == 1)
    {
        leng +=1;
    }
    Byte bbte[leng];
    for (int i = 0; i<leng-1; i++)
    {
        bbte[i] = (int)strtoul([[bcdstr substringWithRange:NSMakeRange(i*2, 2)]UTF8String], 0, 16);
    }
    if (bcdstr.length%2 == 1)
    {
        bbte[leng-1] = (int)strtoul([[bcdstr substringWithRange:NSMakeRange((leng - 1)*2, 1)]UTF8String], 0, 16) *16;
    }else
    {
        bbte[leng-1] = (int)strtoul([[bcdstr substringWithRange:NSMakeRange((leng - 1)*2, 2)]UTF8String], 0, 16);
    }
    return [[[NSData alloc]initWithBytes:bbte length:leng] autorelease];
}

- (NSString *)generateAesKey:(int)size
{
    char data[size/2];
    for (int x = 0;x < size/2;x++)
    {
        int randomint = arc4random_uniform(2);
        if (randomint == 0) {
            data[x] = (char)('A' + (arc4random_uniform(26)));
        }
        else
        {
            data[x] = (char)('0' + (arc4random_uniform(9)));
        }
        
    }
    return [EncryptDecrypt hex2StrUpper:[NSData dataWithBytes:data length:size/2]];;
}

- (NSString*)dataDecrypt:(NSData*)rawData{
    
    //将data型base64 转换成utf8 base64,再转成UTF8字符串
    NSData* base64DecodeData = [GTMBase64 decodeData:rawData];
    NSString* base64DecodeString = [[[NSString alloc] initWithData:base64DecodeData encoding:NSUTF8StringEncoding] autorelease];
    
    //hex化的key 用什么key看服务器
//    NSData * hexKey = [EncryptDecrypt strUpper2hex:ServerAESKey];
    
    //解码
    NSData * temp = [EncryptDecrypt strUpper2hex:base64DecodeString];
    NSData* decryptContentData = [temp decryptedAES256DataUsingKey:ServerAESKey error:nil];
    NSString* decryptContentStr = [[NSString alloc] initWithData:decryptContentData encoding:NSUTF8StringEncoding];
    return [decryptContentStr autorelease];
}

- (NSString*)stringEncrypt:(NSString*)rawStr{


    //将key hex化 
//    NSData* aesKeyData = [EncryptDecrypt strUpper2hex:ClientAESKey];
    
    //将数据data
    NSData* rawData = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* aesEncryptError = nil;
    
    //aes编码
    NSString* encryptedContent = [EncryptDecrypt hex2StrUpper:[rawData AES256EncryptedDataUsingKey:ClientAESKey error:&aesEncryptError]];
    if (aesEncryptError) {
        return nil;
    }
    
    //将aes码base64化
    NSString* encypted = [GTMBase64 stringByEncodingData:[NSData dataWithBytes:[encryptedContent UTF8String] length:[encryptedContent length]]];
    
    return encypted;
}

- (NSString *)RSAEncryptString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [self RSAEncryptData: data];
    return [EncryptDecrypt hex2StrUpper:encryptedData];
}

- (NSString *)RSADecryptString:(NSString *)string
{
    NSData *stringData = [self encodeBCD:string];
    NSData *decryptStringData = [self RSADecryptData:stringData];
    
    NSString* decryptKeyStr = [[NSString alloc] initWithData:decryptStringData encoding:NSUTF8StringEncoding];
    return [decryptKeyStr autorelease];
}

- (NSData*)RSADecryptData:(NSData*)data{

    SecKeyRef keyRef = [self loadPrivateKey:RSA_Private_Key];
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[[NSMutableData alloc] init] autorelease];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
                      ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
- (NSData*)RSAEncryptData:(NSData*)data {
    SecKeyRef key = [self loadPublicKey:RSA_Public_key];
    
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(key) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[[NSMutableData alloc] init] autorelease];
    for(int idx = 0; idx < srclen; idx += src_block_size){
        size_t data_len = srclen - idx;
        if (data_len > src_block_size) {
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(key,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    return ret;
}

- (SecKeyRef)loadPrivateKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = [GTMBase64 decodeString:key];
    data = [self stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[[NSMutableDictionary alloc] init] autorelease];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

- (SecKeyRef)loadPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = [GTMBase64 decodeString:key];
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[[NSMutableDictionary alloc] init] autorelease];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

- (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

//credit: http://hg.mozilla.org/services/fx-home/file/tip/Sources/NetworkAndStorage/CryptoUtils.m#l1036
- (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

@end
