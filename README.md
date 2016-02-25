# Smaato

## Brief:

The Application was developed using the latest version of Xcode. No framework was used as described in the test documentation.

## SmaatoLibrary:

In order to make the project more reusable and extendable I created a separated Library which you could use in other projecs if wanted.

###Instalattion: 

You just have to drag and drop the SmaatoLibrary.a file into your project folder. (in an ideal case I would create a Pod and would install it via Cocoapods due the convenience in maintaining the code.)

## Usage

### SMTNetwork

`SMTNetwork` creates and manages an `NSURLSession` object based on a specified `NSURLSessionConfiguration` currently it supports POST and GET methods

#### Making a GET HTTP Request

```objective-c
[[SMTNetwork instance] requestWithURL: url method: GET parameters: nil success:^(NSArray *data, NSURLResponse *response) {
        .
        .
        .
        
    } failure:^(NSError *error) {
        .
        .
        .
    }];

```

#### Making a POST HTTP Request

```objective-c
[[SMTNetwork instance] requestWithURL: url method: POST parameters: @{@"foo" : @"baar"} success:^(NSArray *data, NSURLResponse *response) {
        .
        .
        .
        
    } failure:^(NSError *error) {
        .
        .
        .
    }];
```

## To be improved

In order to make `SMTNetwork` even more reusable and extendable the `SMTSuccess` should be changed to id instead of always be n NSArray therefore we could handle more types of response.


