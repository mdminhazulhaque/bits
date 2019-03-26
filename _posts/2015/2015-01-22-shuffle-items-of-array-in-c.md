---
layout: post
title: "Shuffle Items of an Array in C"
date: 2015-01-22 20:16:00
categories: C
---
C does not come up with C++ like shuffle or random_shuffle templates. So an easy trick to shuffle the items of an array could be -

  1. Create an integer array of indexes
  2. Shuffle the array of integer indexes
  3. Access the array of items with the new shuffled indexes

For example, products is an array of strings.

```cpp
char *products[] = {
    "youtube", "translate", "earth", "chrome", "hangout",
    "drive", "maps", "blogger", "adsense", "gmail"
};
```

Now let's create an array of integers from 0 to 9 for indexing these 10 items.

```cpp
int arr[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
```

Now let's shuffle this array using rand() and swap().

```cpp
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void randomize(int arr[], int n) {
    srand(time(NULL));
    int i;
    for(i = n-1; i > 0; i--) {
        int j = rand() % (i+1);
        swap(&arr[i], &arr[j]);
    }
}

randomize (arr, n);
```

Now print the array products using the randomized indexes.

```cpp
for(i=0; i<n; i++) {
    int index = arr[i];
    printf("%2d - %s\n", i+1, products[index]);
}
```

Here is the complete code.

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void randomize(int arr[], int n) {
    srand(time(NULL));
    int i;
    for(i = n-1; i > 0; i--) {
        int j = rand() % (i+1);
        swap(&arr[i], &arr[j]);
    }
}

int main() {
    int arr[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int n = sizeof(arr)/ sizeof(arr[0]);
    char *products[] = {
    "youtube", "translate", "earth", "chrome", "hangout", "drive", "maps", "blogger", "adsense", "gmail"
    };
    printf("before shuffle\n");
    int i;
    for(i=0; i<n; i++) {
        int index = arr[i];
        printf("%2d - %s\n", i+1, products[index]);
    }
    printf("after shuffle\n");
    randomize (arr, n);
    for(i=0; i<n; i++) {
        int index = arr[i];
        printf("%2d - %s\n", i+1, products[index]);
    }
    return 0;
}
```

Output

```cpp
before shuffle
    1 - youtube
    2 - translate
    3 - earth
    4 - chrome
    5 - hangout
    6 - drive
    7 - maps
    8 - blogger
    9 - adsense
    10 - gmail
after shuffle
    1 - adsense
    2 - chrome
    3 - hangout
    4 - earth
    5 - translate
    6 - maps
    7 - gmail
    8 - youtube
    9 - drive
    10 - blogger
```
