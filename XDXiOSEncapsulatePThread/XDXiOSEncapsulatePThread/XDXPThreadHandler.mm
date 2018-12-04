//
//  XDXPThreadHandler.m
//  XDXiOSEncapsulatePThread
//
//  Created by 小东邪 on 2018/11/27.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import "XDXPThreadHandler.h"
#import "log4cplus.h"
#import <pthread.h>

static const char ModuleName[30] = "XDXBaseThread";

#define XDXThreadName   "XDXBaseThread"
#define XDXUSleepOneSec 1000000

@interface XDXPThreadHandler ()
{
    pthread_t           _baseThread;
    bool                _isStopBaseThread;
    bool                _isPauseBaseThread;
    
    pthread_mutex_t     _baseThreadMutex;
    pthread_cond_t      _baseThreadCond;
}

@end

@implementation XDXPThreadHandler

void * doBaseThreadTask(void *param);

void * doBaseThreadTask(void *param) {
    XDXPThreadHandler *instance = (__bridge_transfer XDXPThreadHandler *)param;
    pthread_setname_np(instance.baseThreadName.UTF8String);
    
    while (instance->_isStopBaseThread == false) {
        if (true == instance->_isPauseBaseThread) {
            pthread_mutex_lock(&instance->_baseThreadMutex);
            pthread_cond_wait(&instance->_baseThreadCond,&instance->_baseThreadMutex);
            pthread_mutex_unlock(&instance->_baseThreadMutex);
        }else {
            [instance doBaseThreadTask];
            usleep(XDXUSleepOneSec);
        }
    }
    
    return NULL;
}

- (void)initBaseThread {
    _isStopBaseThread  = false;
    _isPauseBaseThread = false;
    pthread_mutex_init(&_baseThreadMutex, NULL);
    pthread_cond_init(&_baseThreadCond, NULL);
}

#pragma mark - Main Function
- (BOOL)isStopBaseThread {
    return _isStopBaseThread;
}

- (BOOL)isPauseBaseThread {
    return _isPauseBaseThread;
}

- (void)startBaseThreadTask {
    [self initBaseThread];
    pthread_create(&_baseThread, NULL, doBaseThreadTask, (__bridge_retained void *)self);
    log4cplus_error("XDXPThreadHandler", "%s - Start send BaseThread info thread !",ModuleName);
}

- (void)stopBaseThreadTaskThread {
    if (_baseThread) {
        log4cplus_error("XDXPThreadHandler", "%s - Stop send BaseThread thread !",ModuleName);
        [self freeResource];
    }else {
        log4cplus_error("XDXPThreadHandler", "%s - Stop send BaseThread thread Failed, The base thread was destoryed!",ModuleName);
    }
}

- (void)pauseBaseThread {
    if (_isPauseBaseThread == false) {
        pthread_mutex_lock(&_baseThreadMutex);
        _isPauseBaseThread = true;
        pthread_mutex_unlock(&_baseThreadMutex);
        log4cplus_info("Crop", "Suspend send BaseThread info Thread !");
    }else {
        log4cplus_error("Crop", "The send BaseThread info thread had Suspend!");
    }
    
}

- (void)continueBaseThread {
    if (_isPauseBaseThread == true) {
        pthread_mutex_lock(&_baseThreadMutex);
        _isPauseBaseThread = false;
        pthread_cond_broadcast(&_baseThreadCond);
        pthread_mutex_unlock(&_baseThreadMutex);
        log4cplus_info("Crop", "Resume send BaseThread info Thread !");
    }else {
        log4cplus_error("Crop", "The send BaseThread info Thread is running!");
    }
}

#pragma mark - Private Method
- (void)freeResource {
    _isStopBaseThread = true;
    
    pthread_mutex_destroy(&_baseThreadMutex);
    pthread_cond_destroy(&_baseThreadCond);
    
    int err = pthread_join(_baseThread, NULL);
    if (err != 0) {
        log4cplus_error("XDXPThreadHandler", "%s - Destory send BaseThread thread faild. status : %d",ModuleName,err);
    }else {
        log4cplus_error("XDXPThreadHandler", "%s - Destory send BaseThread thread !",ModuleName);
    }
    
    _baseThread  = NULL;
    _isStopBaseThread  = false;
    _isPauseBaseThread = false;
    
    log4cplus_error("XDXPThreadHandler", "%s - Free send BaseThread info thread !",ModuleName);
}

- (void)doBaseThreadTask {

}

@end
