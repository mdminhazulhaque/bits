---
layout: post
title: "Weka: Train and Test Datasets using Java"
date: 2015-10-11 03:09:00
categories: ml
---

A simple Java code to load ARFF datasets into [Weka](http://www.cs.waikato.ac.nz/ml/weka/), train using J48 classifier and test random patterns.

### WekaTest.java

```java
import java.io.BufferedReader;
import java.io.FileReader;

import weka.classifiers.Classifier;
import weka.classifiers.trees.J48;
import weka.core.Instances;

public class WekaTest {

    public static void main(String[] args) throws Exception {

            Classifier j48tree = new J48();
            Instances train = new Instances(new BufferedReader(new FileReader("/home/minhaz/weka/data/diabetes.arff")));
            int lastIndex = train.numAttributes() - 1;
            
            train.setClassIndex(lastIndex);
            
            Instances test = new Instances(new BufferedReader(new FileReader("/home/minhaz/weka/data/diabetes-test.arff")));
            test.setClassIndex(lastIndex);
            
            j48tree.buildClassifier(train);
            
            for(int i=0; i<test.numInstances(); i++) {
            
                    double index = j48tree.classifyInstance(test.instance(i));
                    String className = train.attribute(lastIndex).value((int)index);
                    System.out.println(className);
            }
    }
}
```

### diabetes.arff

```
@relation pima_diabetes
@attribute 'preg' real
@attribute 'plas' real
@attribute 'pres' real
@attribute 'skin' real
@attribute 'insu' real
@attribute 'mass' real
@attribute 'pedi' real
@attribute 'age' real
@attribute 'class' { tested_negative, tested_positive}
@data
6,148,72,35,0,33.6,0.627,50,tested_positive
1,85,66,29,0,26.6,0.351,31,tested_negative
8,183,64,0,0,23.3,0.672,32,tested_positive
1,89,66,23,94,28.1,0.167,21,tested_negative
0,137,40,35,168,43.1,2.288,33,tested_positive
5,116,74,0,0,25.6,0.201,30,tested_negative
..........................................
```

### diabetes-test.arff

```
@relation pima_diabetes
@attribute 'preg' real
@attribute 'plas' real
@attribute 'pres' real
@attribute 'skin' real
@attribute 'insu' real
@attribute 'mass' real
@attribute 'pedi' real
@attribute 'age' real
@attribute 'class' { tested_negative, tested_positive}
@data
6,148,72,35,0,33.6,0.627,50,?
1,85,66,29,0,26.6,0.351,31,?
```

### Output

```
tested_positive
tested_negative
```
