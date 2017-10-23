//
//  AppDelegate.m
//  SQLCiperSpeed
//
//  Created by NItesh on 23/10/17.
//  Copyright © 2017 NItesh. All rights reserved.
//

#import "AppDelegate.h"
#import "DTHSQLCipherUtils.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // === SQLCipher examples start here ===
    
    // File paths for our test DBs
    // A SQLCipher-encrypted DB
    const char *encryptedDbPath = [[@"~/Library/encrypted.db" stringByExpandingTildeInPath] UTF8String];
    
    // A regular SQLite DB
    const char *plaintextDbPath = [[@"~/Library/plaintext.db" stringByExpandingTildeInPath] UTF8String];
    
    // A regular SQLite DB converted to a SQLCipher-encrypted DB
    const char *convertedDbPath = [[@"~/Library/converted.db" stringByExpandingTildeInPath] UTF8String];
    
    // Cleanup previous DBs
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithUTF8String:encryptedDbPath] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithUTF8String:plaintextDbPath] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithUTF8String:convertedDbPath] error:nil];
    
    
    
    // Example #1: create an encrypted DB using SQLcipher
    [DTHSQLCipherUtils createDatabaseAtPath:encryptedDbPath shouldEncrypt:YES];
    [DTHSQLCipherUtils populateDatabase:encryptedDbPath isEncrypted:YES];
    
    // Validate the DB's integrity by ensuring that it contains our test data
    if (![[DTHSQLCipherUtils fetchContentFromDatabase:encryptedDbPath isEncrypted:YES] isEqualToString:@"testest123"]) {
        // This should not happen
        NSLog((@"Encrypted DB: Error!"));
    }
    else {
        NSLog((@"Encrypted DB: OK!"));
    }
    
    
    
    // Example #2: create a plaintext DB and then convert it to an encrypted DB
    // Create the plaintext DB
    [DTHSQLCipherUtils createDatabaseAtPath:plaintextDbPath shouldEncrypt:NO];
    [DTHSQLCipherUtils populateDatabase:plaintextDbPath isEncrypted:NO];
    
    if (![[DTHSQLCipherUtils fetchContentFromDatabase:plaintextDbPath isEncrypted:NO] isEqualToString:@"testest123"]) {
        // This should not happen
        NSLog((@"Plaintext DB: Error!"));
    }
    else {
        NSLog((@"Plaintext DB: OK!"));
    }
    
    // Convert the plaintext DB to an encrypted DB
    [DTHSQLCipherUtils convertDatabaseAtPath:plaintextDbPath toEncryptedDatabaseAtPath:convertedDbPath];
    
    // Validate the new encrypted DB's integrity by ensuring that it contains our test data
    if (![[DTHSQLCipherUtils fetchContentFromDatabase:convertedDbPath isEncrypted:YES] isEqualToString:@"testest123"]) {
        NSLog((@"Converted DB: Error!"));
    }
    else {
        NSLog((@"Converted DB: OK!"));
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
