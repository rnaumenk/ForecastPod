# RecastAI - iOS SDK

[logo]: https://github.com/RecastAI/SDK-ios/blob/master/Misc/logo-inline.png "Recast.AI"

[![Version](https://img.shields.io/cocoapods/v/RecastAI.svg?style=flat)](http://cocoapods.org/pods/RecastAI)
[![License](https://img.shields.io/cocoapods/l/RecastAI.svg?style=flat)](http://cocoapods.org/pods/RecastAI)
[![Platform](https://img.shields.io/cocoapods/p/RecastAI.svg?style=flat)](http://cocoapods.org/pods/RecastAI)

![alt text][logo]

Recast.AI official SDK in Swift.

## 42 Swift Pool

If you are working with Swift 2.0+ use this version : ~> 2.1.1 ! 

## Synospis

This pod is a Swift interface to the [Recast.AI](https://recast.ai) API. It allows you to make requests to your bots.

## Requirements

- iOS 10.0+
- Xcode 8.0+

## Installation

RecastAI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RecastAI"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### RecastAIClient

This class handles everything. Create a RecastAIClient object and init it with your token. The RecastAIClient can also be instanciated with a language (optional).
```swift
import RecastAI

class ViewController: UIViewController
{
    //Vars
    var bot : RecastAIClient?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.bot = RecastAIClient(token : "YOUR_TOKEN")
        self.bot = RecastAIClient(token : "YOUR_TOKEN", language: "YOUR_LANGUAGE")
    }
}
```

## Specs

### Classes

This module contains 3 classes, as follows:

* Client is the client allowing you to make requests.
* Response contains the response from [Recast.AI](https://recast.ai).
* Intent represents an Intent of the response

Don't hesitate to dive into the code, it's commented ;)

## class Client

The Client can be instanciated with a token and a language (both optional).

```swift
let bot = RecastAIClient(token : "YOUR_TOKEN", language: "YOU_LANGUAGE")
```

__Your tokens:__

[token]: https://github.com/RecastAI/SDK-NodeJs/blob/master/misc/recast-ai-tokens.png "Tokens"

![alt text][token]

*Copy paste your request access token from your bot's settings.*

__Your language__

```swift
let bot = RecastAIClient(token : "YOUR_TOKEN", language: "en")
```
*The language is a lowercase 639-1 isocode.*

## Text Request

The `textRequest` method allows you to make a request to the Recast.AI API. The `textRequest` method is to make a **Text** request and takes a **text** as a `String` as parameter and a **language** as a `String` or a `Token` as **optional parameters**. You also need to provide a `successHandle` and a `failureHandle` functions that will be called when either the request is done or the request fails.
If you pass a token or a language in the options parameter, it will override your default client language or token.


```swift
/**
Make text request to Recast.AI API
*/
func makeRequest()
{
    //Call makeRequest with string parameter to make a text request
    self.bot?.textRequest(<#T##request: String##String#>, successHandler: <#T##(Response) -> Void#>, failureHandle: <#T##(Error) -> Void#>)
}
```

__If a language is provided:__ the language you've given is used for processing if your bot has expressions for it, else your bot's primary language is used.

__If no language is provided:__ the language of the text is detected and is used for processing if your bot has expressions for it, else your bot's primary language is used for processing.

## Text Converse

The `textConverse` method allows you to make a request to the Recast.AI Bot Builder API. The `textConverse` method is to make a **Converse** request and takes a **text** as a `String` as parameter and a **language** as a `String`, a `Token`, a `ConverseToken` as **optional parameters**. You also need to provide a `successHandle` and a `failureHandle` functions that will be called when either the request is done or the request fails.
If you pass a token or a language in the options parameter, it will override your default client language or token. The converse token is unique ID you need to provide in order to access the a specific conversation.


```swift
/**
Make text request to Recast.AI API
*/
func makeRequest()
{
//Call makeRequest with string parameter to make a converse request
self.bot?.textConverse(<#T##request: String##String#>, converseToken: "YOUR_CONVERSATION_UNIQUE_ID", successHandler: <#T##(Response) -> Void#>, failureHandle: <#T##(Error) -> Void#>)
}
```

## File Request

In order to make a **File** Request you need to implement two methods you need to pass a file as a parameter. You also need to provide a `successHandle` and a `failureHandle` functions that will be called when either the request is done or the request fails.
If you pass a token or a language in the options parameter, it will override your default client language or token.

__file format: .wav__

```swift
/**
Make File request to Recast.AI API
*/
func makeFileRequest()
{
    if (!(self.requestTextField.text?.isEmpty)!)
    {
        let url = URL(string: self.requestTextField.text!)!
        //Call makeRequest with string parameter to make a text request
        self.bot?.fileRequest(<#T##audioFileURL: URL##URL#>, successHandler: <#T##(Response) -> Void#>, failureHandle: <#T##(Error) -> Void#>)
    }
}
```

## class Response

The Response is generated after a call to either fileRequest or textRequest.

### Get the first detected intent

| Method        | Params | Return                    |
| ------------- |:------:| :-------------------------|
| intent()      |        | Object: the first detected intent |

```swift
/**
Method called when the request was successful

- parameter response: the response returned from the Recast API

- returns: void
*/
func recastRequestDone(_ response : Response)
{
    let intent = response.intent()
    print(intent.slug)
}
```

### Get one entity

| Method        | Params        | Return                    |
| ------------- |:-------------:| :-------------------------|
| get(name)     | name: String  | Entity: the first Entity matched  |

```swift
/**
Method called when the request was successful

- parameter response: the response returned from the Recast API

- returns: void
*/
func recastRequestDone(_ response : Response)
{
    let location = response.get('location')
}
```

### Get all entities matching name

| Method        | Params        | Return                    |
| ------------- |:-------------:| :-------------------------|
| all(name)     | name: String  | Array[Entity]: all the Entities matched  |

```swift
/**
Method called when the request was successful

- parameter response: the response returned from the Recast API

- returns: void
*/
func recastRequestDone(_ response : Response)
{
    let locations = response.all('location')
}
```

### Act helper

| Method        | Params | Return                                  |
| ------------- |-------:| :---------------------------------------|
| isAssert()    |        | Bool: wheither or not the act is an assertion |
| isCommand()   |        | Bool: wheither or not the act is a command    |
| isWhQuery()   |        | Bool: wheither or not the act is a wh-query   |
| isYnQuery()   |        | Bool: wheither or not the act is a yn-query   |

### Type helper

| Method           | Params | Return                                                     |
| ---------------- |-------:| :----------------------------------------------------------|
| isAbbreviation() |        | Bool: wheither or not the sentence is asking for an abbreviation |
| isEntity()       |        | Bool: wheither or not the sentence is asking for an entity       |
| isDescription()  |        | Bool: wheither or not the sentence is asking for a description   |
| isHuman()        |        | Bool: wheither or not the sentence is asking for a human         |
| isLocation()     |        | Bool: wheither or not the sentence is asking for a location      |
| isNumber()       |        | Bool: wheither or not the sentence is asking for a number        |

### Sentiment helper

| Method        | Params | Return                                    |
| ------------- |-------:| :-----------------------------------------|
| isVPositive()  |        | Bool: wheither or not the sentiment is very positive |
| isPositive()  |        | Bool: wheither or not the sentiment is positive |
| isNeutral()   |        | Bool: wheither or not the sentiment is neutral  |
| isNegative()  |        | Bool: wheither or not the sentiment is negative |
| isVNegative()  |        | Bool: wheither or not the sentiment is very negative |

### Attributes

Each of the following methods corresponds to a Response attribute

| Attributes  | Type                                                |
| ----------- | :---------------------------------------------------|
| raw         | String: the raw unparsed json response              |
| type        | String: the type of the processed sentence          |
| act         | String: the act of the processed sentence           |
| sentiment   | String: the sentiment of the processed sentence     |
| source      | String: the user input                              |
| intents     | Array[object]: all the matched intents              |
| status      | String: the status of the response                  |
| version     | String: the version of the json                     |
| timestamp   | String: the timestamp at the end of the processing  |

### Attributes

Each of the following methods corresponds to a Response attribute

| Attributes  | Description                                                   |
| ----------- |:--------------------------------------------------------------|
| name        | String: the name of the entity                                |
| raw         | String: the unparsed json value of the entity                 |

In addition to those methods, more attributes are generated depending of the nature of the entity.
The full list can be found there: [man.recast.ai](https://man.recast.ai/#list-of-entities)

```swift
/**
Method called when the request was successful

- parameter response: the response returned from the Recast API

- returns: void
*/
func recastRequestDone(_ response : Response)
{
    let location = response.get('location')
    print(location["latitude"])
}
```

## Error

We will call `recastRequestError` with Error as parameter.
For more information about Recast Errors check out our [man#error](https://man.recast.ai/#request-text)

## More

You can view the whole API reference at [man.recast.ai](https://man.recast.ai)

## Author

PE Lieb, pierre-edouard.lieb@recast.ai, [@pedward_lieb](https://twitter.com/pedward_lieb)

You can follow us on Twitter at [@recastai](https://twitter.com/recastai) for updates and releases.

## License

RecastAI is available under the MIT license.

Copyright (c) [2016] [Recast.AI](https://recast.ai)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
