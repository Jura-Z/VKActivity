//
//  VKUploadPhotoRequest.m
//
//  Copyright (c) 2013 VK.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "VKUploadPhotoRequest.h"
#import "VKApi.h"
@implementation VKUploadPhotoRequest
- (instancetype)initWithImage:(UIImage *)image parameters:(VKImageParameters *)parameters albumId:(int)albumId groupId:(int)groupId {
	self = [super init];
	self.image            = image;
	self.imageParameters  = parameters;
	self.albumId          = albumId;
	self.groupId          = groupId;
	return self;
}

- (VKRequest *)getServerRequest {
	if (self.albumId && self.groupId)
		return [[VKApi photos] getUploadServer:self.albumId andGroupId:self.groupId];
	else
		return [[VKApi photos] getUploadServer:self.albumId];
}

- (VKRequest *)getSaveRequest:(VKResponse *)response {
	VKRequest *saveRequest = [[VKApi photos] save:response.json];
	if (self.albumId)
		[saveRequest addExtraParameters:@{ VK_API_ALBUM_ID : @(self.albumId) }];
	if (self.groupId)
		[saveRequest addExtraParameters:@{ VK_API_GROUP_ID : @(self.groupId) }];
	return saveRequest;
}

@end
