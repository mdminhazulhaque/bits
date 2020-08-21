---
layout: post
title: "Some Regex Examples"
date: 2015-04-10 03:41:00
category: regex
---
Regular expression for any binary string:

    REGEXP: [01]*
    ACCEPT: 0
    ACCEPT: 1
    ACCEPT: 00
    ACCEPT: 10
    ACCEPT: 111010101010111
    REJECT: cat
    REJECT: 123
    REJECT: he110, w0r1d

Regular expression for any binary string that represents an unsigned integer
that is EVEN:

    REGEXP: [01]*0
    ACCEPT: 0
    ACCEPT: 10
    ACCEPT: 1110
    ACCEPT: 010
    ACCEPT: 00011000110110
    REJECT: 1
    REJECT: 011
    REJECT: 0101

Regular expression for any binary string of EVEN length:

    REGEXP: ([01]{2})*
    ACCEPT: 00
    ACCEPT: 01
    ACCEPT: 1010
    ACCEPT: 0001
    ACCEPT: 0001101100011011
    REJECT: 0
    REJECT: 1
    REJECT: 111
    REJECT: 010
    REJECT: 0001101

Regular expression for any binary string that contains the pattern 0110 OR the
pattern 1001:

    REGEXP: .*(0110|1001).*
    ACCEPT: 0110
    ACCEPT: 1001
    ACCEPT: 01101001
    ACCEPT: 011001
    ACCEPT: 111101101111
    ACCEPT: 0000010010000
    REJECT: 0
    REJECT: 1
    REJECT: 0101
    REJECT: 1010
    REJECT: 1100010001110

Regular expression for any binary string that contains the pattern 0110 AND
the pattern 1001:

    REGEXP: .*((1001.*0110)|(0110.*1001)|011001|100110).*
    ACCEPT: 01101001
    ACCEPT: 000110001001000
    ACCEPT: 011001
    ACCEPT: 100110
    ACCEPT: 000011001000
    REJECT: 0
    REJECT: 1
    REJECT: 0110
    REJECT: 1001
    REJECT: 01101
    REJECT: 10010
    REJECT: 1100010001110

<div>{% include ad_article.html %}</div>

Regular expression that will accept three or four words:

    REGEXP: ([\w]*\s){2,3}[\w?]*
    ACCEPT: one two three
    ACCEPT: one two three four
    ACCEPT: 1 2 3 4
    ACCEPT: how many words?
    REJECT: word
    REJECT: word word
    REJECT: word word word word word

Regular expression that will accept the word cat and the word hat with at most
2 other words between them:

    REGEXP: cat\s(\w*\s){0,2}hat
    ACCEPT: cat hat
    ACCEPT: cat in hat
    ACCEPT: cat in the hat
    REJECT: hat cat
    REJECT: cathat
    REJECT: catinthehat
    REJECT: cat in the phat hat
    REJECT: cat in the super phat hat

Regular expression that will accept a properly formatted 24-hour time (0:00
... 23:59):

    REGEXP: ((1?[0-9])|(2[0-3])):[0-5][0-9]
    ACCEPT: 12:34
    ACCEPT: 0:00
    ACCEPT: 23:59
    ACCEPT: 9:00
    ACCEPT: 10:00
    ACCEPT: 11:11
    ACCEPT: 15:15
    REJECT: 24:00
    REJECT: 12:32 pm
    REJECT: 0:60
    REJECT: 9:99
    REJECT: 04:00
    REJECT: 4
    REJECT: -4:00

Regular expression for a binary string that has no consecutive 0's and no
consecutive 1's:

    REGEXP: ((01)*0?)|((10)*1?)
    ACCEPT: 1
    ACCEPT: 0
    ACCEPT: 10
    ACCEPT: 01
    ACCEPT: 101
    ACCEPT: 010
    ACCEPT: 1010
    ACCEPT: 0101
    ACCEPT: 10101
    ACCEPT: 01010
    ACCEPT: 101010
    ACCEPT: 010101
    REJECT: 00
    REJECT: 11
    REJECT: 001
    REJECT: 100
    REJECT: 110
    REJECT: 011
    REJECT: 1001
    REJECT: 0110
    REJECT: 01010100101010
    REJECT: 10101011010101

Regular expression for a binary string that represents an unsigned value that
is divisible by 3:

    REGEXP: (1(01*0)*1|0)*
    ACCEPT: 11
    ACCEPT: 110
    ACCEPT: 1001
    ACCEPT: 1100
    ACCEPT: 10101
    ACCEPT: 11011
    ACCEPT: 100001
    ACCEPT: 111111
    ACCEPT: 1110101
    ACCEPT: 101010110
    ACCEPT: 000111000101
    REJECT: 1
    REJECT: 10
    REJECT: 100
    REJECT: 111
    REJECT: 110001
    REJECT: 1000100
    REJECT: 10010010
    REJECT: 10101100
    REJECT: 11100101
    REJECT: 11011101
    REJECT: 110110111
