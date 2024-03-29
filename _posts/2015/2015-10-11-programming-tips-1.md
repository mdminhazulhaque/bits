---
layout: post
title: "সি++ প্রোগ্রামিং টিপস: পর্ব ১"
date: 2015-10-11 03:51:00
category: cpp
permlink: /cpp/programming-tips-1.html
---
আজকাল পড়াশোনার কাজে হোক, রিসার্চের কাজে হোক, জীবন চালাতে হোক প্রোগ্রামিং একটা অবিচ্ছেদ্য অংশ হয়ে গেছে।  তবে প্রোগ্রামিং মানে শুধু ল্যাংগুয়েজের সিনট্যাক্স জেনে Hello World প্রিন্ট করা নয়, প্রোগ্রামিং মানে একটা কনসেপ্ট, একটা প্যারাডাইম, একটা আর্ট। কাজেই প্রোগ্রামিং শিখতে হলে কোডিং এর বাইরেও নিয়ম, শৃঙ্খলা, স্টাইল, বিন্যাস শেখা দরকার। এসবের কম্বিনেশনে প্রোগ্রামিং হয়ে উঠবে একটি শিল্প।

আমার প্রিয় ল্যাংগুয়েজ সি++ বলে সি++ এর জনক [Bjarne Stroustrup](http://www.stroustrup.com/) এর A Tour of C++ বইটি থেকে নিয়মিত কিছু লাইন ব্যাখা করবো যেগুলো শুধু সি++ নয়, অন্যান্য প্রোগ্রামিং ল্যাংগুয়েজেও এপ্লাই করলে কোডের সৌন্দর্য বেড়ে যাবে বহুগুণ।

তো শুরু করা যাক।

## Focus on programming techniques, not on language features

প্রায়ই দেখা যায় ল্যাংগুয়েজ শেখার সময় স্টুডেন্টরা আগে হিসাব নিকাশ করা শুরু করে, কোনটা শিখা সহজ, কোনটা শিখলে ভাল কাজ পাওয়া যাবে, কোনটার কদর বেশী, কোনটায় কাজ করে আরাম, কোনটায় ফিচার বেশী ইত্যাদি। হ্যা, অবশ্যই এমন একটা ল্যাংগুয়েজ জানতে হবে যেটা জনপ্রিয়। যেমন কেও যদি ২০১৫ সালে জাভার বদলে ফরট্রান কিংবা বেসিক নিয়ে পড়ে থাকতে চায় তাহলে অবশ্যই তাকে বর্তমান চাহিদা নিয়ে ভাবতে হবে। কিন্তু ফিচারই সব নয়। একটা ল্যাংগুয়েজ শিখতে হলে দেখতে হবে ল্যাংগুয়েজটার স্টাইল কি, কিভাবে সেটা ইউজ করা যায়, কি কি টেকনিক এপ্লাই করা যায় ওই ল্যাংগুয়েজ দিয়ে ইত্যাদি।

ফিচার কিংবা সিনট্যাক্স দিয়ে ল্যাংগুয়েজ বিচার না করাই ভাল। কারণ প্রতিটা ল্যাংগুয়েজই তৈরী হয়েছে বিভিন্ন প্রয়োজনে। সব ল্যাংগুয়েজেরই সুবিধা অসুবিধা আছে। আর কর্মক্ষেত্রে যার যেটা দরকার সে সেটাই ব্যাবহার করবে। কাজেই প্রোগ্রামিং টেকনিকের দিকে জোর দিতে হবে, ল্যাংগুয়েজ ফিচার নয়।

## A function should perform a single logical operation

প্রোগ্রামিং করার সময় কাজগুলোকে মডিউল আকারে ভাগ করার জন্য ফাংশন ব্যাবহার করা হয়। তাছাড়া `DRY (Don't Repeat Yourself)` কনসেপ্টটিও এপ্লাই করার জন্য ফাংশন জিনিসটা জরুরী।

যেহেতু ফাংশনের উদ্দেশ্যই হল মডিউলার প্রোগ্রামিং, তাই ফাংশনকেও যতটা সম্ভব ছোট, সহজ এবং একটি লজিকাল অপারেশন করা উচিত।

যেমন ধরে নিই আমরা একটি প্রোগ্রাম লিখবো যেটা ১০টি নম্বর ইনপুট নিবে, যোগ করবে এবং প্রিন্ট করে দেখাবে। সাধারণভাবে নিচের মত কোড করলেই চলে।

{% highlight cpp %}
#include <iostream>
using namespace std;

int main()
{
    int numbers[10];
    int sum = 0;
    /** step 1 **/
    cout << "Enter the numbers" << endl;
    for(int i=0; i<10; i++)
        cin >> numbers[i];
    /** step 2 **/
    cout << "Printing the numbers" << endl;
    for(int i=0; i<10; i++)
        cout << numbers[i] << endl;
    /** step 3 **/
    for(int i=0; i<10; i++)
         sum += numbers[i];
    cout << "Sum of the numbers: " << sum << endl;
    return 0;
}
{% endhighlight %}

এখন আমরা যদি এই কোডের তিনটি কাজকে তিনটি ফাংশনে ভাগ করে ফেলতে পারি। কিভাবে? এইরকম একটি উদাহরণ দেওয়া যেতে পারে।

{% highlight cpp %}
#include <iostream>
using namespace std;

void input(int *numbers)
{
    cout << "Enter the numbers" << endl;
    for(int i=0; i<10; i++)
        cin >> numbers[i];
}

void output(int *numbers)
{
    cout << "Printing the numbers" << endl;
    for(int i=0; i<10; i++)
        cout << numbers[i] << endl;
}

void sum(int *numbers)
{
    int sum = 0;
    for(int i=0; i<10; i++)
         sum += numbers[i];
    cout << "Sum of the numbers: " << sum << endl;
}

int main()
{
    int numbers[10];
    input(numbers);
    output(numbers);
    sum(numbers);
    return 0;
}
{% endhighlight %}

দেখেই বোঝা যাচ্ছে যে ফাংশনে ভাগ করে দেওয়ার ফলে `main` ফাংশনে কোডের পরিমাণ কমে গেছে। সেই সাথে অপারেশনগুলো ফাংশনে ভাগ করায় একটি অপারেশনের সাথে অন্য অপারেশনের সম্পর্ক নেই এবং ডাটার এনক্যাপসুলেশন ভাল হয়েছে।


## Keep functions short

যেহেতু ফাংশনের উদ্দেশ্য প্রোগ্রামকে মডিউলার করা, তাই বড় বড় ফাংশন না লিখে ছোট ছোট ফাংশন লেখা উচিত। ফলে প্রোগ্রামের জটিলতা কমে, পড়তে ও বুঝতে সুবিধা হয়। যেমন আমরা আগের উদাহরণটাই রিভিউ করি। ধরে নিলাম মূল প্রোগ্রামটি নিচের মত করে ফাংশন দিয়ে ইমপ্লিমেন্ট করা হল।

{% highlight cpp %}
#include <iostream>
using namespace std;

void task()
{
    int numbers[10];
    int sum = 0;
    cout << "Enter the numbers" << endl;
    for(int i=0; i<10; i++)
        cin >> numbers[i];
    cout << "Printing the numbers" << endl;
    for(int i=0; i<10; i++)
        cout << numbers[i] << endl;
    for(int i=0; i<10; i++)
         sum += numbers[i];
    cout << "Sum of the numbers: " << sum << endl;
}

int main()
{
    task();
    return 0;
}
{% endhighlight %}

এখানে ফাংশন দিয়ে main এ অপারেশন কমিয়ে ফেললেও আসল উদ্দেশ্য কিন্তু বাস্তবায়িত হয়নি কারণ task ফাংশনটির সাইজ বেশী বড় হয়েছে যা আরো কমিয়ে ফেলা সম্ভব।

## Use overloading when functions perform conceptually the same task on different types

ওভারলোডিং, সি++ এর একটি মজার ফিচার। ফাংশন ওভারলোডিং দিয়ে একই নামে একাধিক ফাংশন তৈরী করা যায় শুধুমাত্র প্যারামিটার টাইপ, কাউন্ট বদলিয়ে।

যেমন ধরা যাক আমাদের এমন কয়েকটা ফাংশন দরকার যেগুলো দিয়ে স্ট্রিং, ইনটেজার, রিয়াল নাম্বার প্রিন্ট করা যাবে। তাহলে আমরা যদি নিচের মত ফাংশন তৈরী করি,

{% highlight cpp %}
void print_string(string str)
void print_int(int number)
void print_real(double real)
{% endhighlight %}

তাহলে ইউজারকে প্রতিটা টাইপের জন্য ফাংশনের নাম মনে রাখতে হবে যা আসলেই ঝামেলার কাজ। যদি একটা জেনেরিক নাম দেওয়া হয় এবং ওভারলোডিং এপ্লাই করা হয়, তাহলে এই সমস্যা থেকে মুক্তি পাওয়া সম্ভব। যেমন -

{% highlight cpp %}
#include <iostream>
using namespace std;

void print(string str)
{
    cout << "Got a string, value is " << str << endl;
}

void print(int number)
{
    cout << "Got an integer number, value is " << number << endl;
}

void print(double real)
{
    cout << "Got a real number, value is " << real << endl;
}

int main()
{
    print("hello");
    print(42);
    print(3.14159);
    return 0;
}
{% endhighlight %}

এইখানে কিন্তু তিনরকম টাইপের জন্য একই ফাংশন নেম print ব্যাবহার করা হচ্ছে। ফলে ইউজারকে টাইপ নিয়ে মাথা ঘামাতে হচ্ছেনা, শুধু ফাংশনে প্যারামিটার পাঠিয়ে দিলেই হচ্ছে।

## Avoid "magic constants" use symbolic constants

ম্যাজিক কনসট্যান্ট মানে প্রোগ্রামের ভেতর সরাসরি নম্বর ধ্রুবক আকারে হার্ডকোড করে বসিয়ে দেওয়া। আর সিম্বলিক কনসট্যান্ট মানে একটা রেফারেন্স কনসট্যান্টকে পয়েন্ট করে ব্যাবহার করা। একটা উদাহরণ দিলে বিষয়টা ক্লিয়ার হবে।

ধরে নিই আমাদের একটা প্রোগ্রাম লাগবে যেটা ইউএস ডলার থেকে বাংলাদেশী টাকায় কনভার্ট করতে পারে। সাধারণত ডলার ভ্যালুর সাথে কনভার্শন রেট গুণ করলেই কাজটা করা যায়। একটা ডেমো প্রোগ্রাম দেখা যাক।

{% highlight cpp %}
#include <iostream>
using namespace std;

int main()
{
    int dollar0 = 99;
    cout << dollar0 << " USD = " << dollar0 * 78 << " BDT" << endl;
    int dollar1 = 1200;
    cout << dollar1 << " USD = " << dollar1 * 78 << " BDT" << endl;
    int dollar2 = 499;
    cout << dollar2 << " USD = " << dollar2 * 78 << " BDT" << endl;
    return 0;
}
{% endhighlight %}

এই প্রোগ্রামে 99, 1200, 499 তিনটি ভ্যালু BDT তে কনভার্ট করা হয়েছে 78 দিয়ে গুণ করে। এই প্রোগ্রামে একটাই সমস্যা, সেটা হল কনভার্শন স্টেটমেন্ট বেশী হলে 78 সংখ্যাটা বারবার লিখতে হবে। সেই সাথে কোন কারণে কনভার্শন রেট 78 থেকে কমে 76 কিংবা বেড়ে 80 হলেও প্রতিটা লাইনের জন্য এই মানটা বদলাতে হবে। এইরকম ম্যাজিক কনসট্যান্ট বাদ দিয়ে আমরা সিম্বোলিক কনসট্যান্ট বসাতে পারি। কিভাবে? এইযে একটা উদাহরণ।

{% highlight cpp %}
#include <iostream>
using namespace std;

#define USD_TO_BDT 78

int main()
{
    int dollar0 = 99;
    cout << dollar0 << " USD = " << dollar0 * USD_TO_BDT << " BDT" << endl;
    int dollar1 = 1200;
    cout << dollar1 << " USD = " << dollar1 * USD_TO_BDT << " BDT" << endl;
    int dollar2 = 499;
    cout << dollar2 << " USD = " << dollar2 * USD_TO_BDT << " BDT" << endl;
    return 0;
}
{% endhighlight %}

এখানে একটা সিম্বোলিক কনসট্যান্ট USD_TO_BDT ব্যাবহার করা হয়েছে। ফলে কোনরকম চেঞ্জ চাইলে USD_TO_BDT এইটার মান বদলে দিলেই চলবে। প্রতি লাইনে মান বদলানোর প্রয়োজন নেই।

## Declare one name (only) per declaration

এই পয়েন্টটা সম্ভব সবার শুরুতে দেওয়া উচিত ছিল।

স্টুডেন্টদের প্রোগ্রামিং শেখানোর সময় ভেরিয়েবল ডিক্লেয়ার করা শেখানো হয় কিন্তু ভেরিয়েবলের নেমিং কনভেনশন কিংবা ডিক্লেয়ারেশন পলিসি নিয়ে কিছুই বলা হয়না। একটা উদাহরণ দেই।

যদি কাওকে একটা প্রোগ্রাম করতে বলা হয় যে দুটি নম্বর নাও, তাদের যোগ বিয়োগ গুণ আর ভাগ ফল বের করো, তারপর গড় বের করে সংখ্যা দুটির স্কয়ারের যোগফল বের করো। তাহলে অনেকেই ভেরিয়েবল ডিক্লেয়ার করে এভাবে।

{% highlight cpp %}
float a,b,c,add,sub,mul,div,avg,sqr;
{% endhighlight %}

আদতে এই লাইনটিতে কোন সিনট্যাক্স এরর নাই, এরর হল স্টাইলে। এক লাইনে সবগুলো ভেরিয়েবল ডিক্লেয়ার করার অভ্যাস বাদ দিতে হবে। কেননা এতে কোড দেখতে খুবই বাজে লাগে, লাইনগুলোর সাইজ অতিরিক্ত বড় হয় (কিছু ক্ষেত্রে ৮০ কারেকটার পার হয়ে যায়) আর ভুলের সম্ভাবনা তো আছেই।

তাই ভেরিয়েবল ডিক্লেয়ারেশন যদি আলাদা আলাদা লাইনে এবং রিজনেবল নাম দিয়ে করা যায়, তাহলে দেখতে সুন্দর লাগে, ভুল করার সম্ভাবনাও কমে। যেমন

{% highlight cpp %}
float a; // there you go
float b;
float c; // yolo

float add;
float sub;
float mul;
float div; // not done yet

float avg
float sqr; // done
{% endhighlight %}

হয়ত কয়েক লাইন বেশী লিখতে হবে, কিন্তু এই স্টাইল ফলো করলে কোড অন্যের জন্য বুঝতে সহজ হয়, ডকুমেন্টেশন ও কমেন্টিং করার কাজটাও সহজে করা যায়।

আজকের মত এপর্যন্তই থাক। আগামী পর্বে আরো বিষয় নিয়ে লিখবো। সাথেই থাকুন।
