---
layout: post
title: "Some words about Qt DOM Node, Element and Attribute"
date: 2015-01-02 21:41:00
tag: qt
---
##  Add Instruction Node

Every valid XML must contain processing instruction. XML is widely used for
HTML, SVG, XLS etc. So make sure your XML file has valid instruction of its
type and encoding. The following line is a sample XML processing instruction.

```xml
<?xml version="1.0" encoding="UTF-8"?>
```

##  Skip Instruction Node While Reading XML

I don't know how you read XML nodes and values. Most examples out there use
parent and child counts. Obviously, DOM processing instruction is a node.
Let's refer the following XML file.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<properties>
    <node type="user">minhaz</node>
    <node type="os">linux</node>
    <node type="version">3.2.0-37</node>
</properties>
```

A valid XML must start with a root element. Here `properties` is a root
element. It has 3 child nodes. Each node has `node value` and
**attribute**. So how do we parse the whole XML? If we refer the whole
document as a node, then the first line, processing instruction, will be
regarded as a node. So properties will be the 2nd child node, but technically,
it is the first/root node. So instead of using
`document.childNodes().at(1)` method, we could use
`document.namedItem("properties")` to get list of all child nodes under
properties tag. Here is a sample code.

```cpp
QDomDocument document;
document.setContent(xmlString);
QDomNode root = document.namedItem("properties");
QDomNodeList nodes = root.childNodes();

for(int i=0;i<nodes.count();i++)
{
    qDebug() << "Type: " << nodes.at(i).toElement().attribute("type")
        << " Value: " << nodes.at(i).toElement().text();
}
```

And this will result into the following output.

```cpp
Type:  "user"  Value:  "minhaz" 
Type:  "os"  Value:  "linux" 
Type:  "version"  Value:  "3.2.0-37"
```

Any more confusion? Or a better method? Let me know.

##  Create XML and Write into File

Parsing XML is easy. The structure is already preset there. Just detect the
hierarchy and parse. But what about creating your own? Perhaps from an user
defined directory tree? I went into this painful issue, and then found the
correct solution.

What if we try to generate an XML from the previous text output. Assume that
we have two string lists.

```cpp
QStringList attributeValues = QStringList() << "user" << "os" << "version";
QStringList nodeValues = QStringList() << "minhaz" << "linux" << "3.2.0-37";
```

We need to create an XML using these strings, and with a processing
instruction. Lets get started.


First, create a DOM document. (Don't blame me unless you added `qt += xml`
to your project file) Then declare a QDomDocument object.

```cpp
QDomDocument document;
```

Now create a QDomProcessingInstruction object with correct encoding and XML
version. Then add it as child node of document.

```cpp
QDomProcessingInstruction header = document.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-8\"");
document.appendChild(header);
```

Now move to root node with tagname `properties`. Create a QDomElement
object and append it to root.

```cpp
QDomElement root = document.createElement("properties");
document.appendChild(root);
```

Then we will add child nodes under `properties` tag. Most people might
think that the following line would add child nodes under root.

```cpp
QDomNode child;
root.appendChild(child);
```

**NO! That is wrong**. You must create every node or elements using the reference of document. Just keep in mind that there might be more than one documents in codes. So you should not mess with parents and childs. The following lines will generate child nodes under `properties` tag.  

```cpp
QDomElement node = document.createElement("node");
root.appendChild(node);
```

Did you spot the difference? You have to use `document.createElement`, not
root.appendChild method. As we have a list of strings, so we can use a loop to
create all nodes and set values to them.

```cpp
for(int i=0;i<attributeValues.size();i++)
{
    QDomElement node = document.createElement("node");
    node.setAttribute("type",attributeValues.at(i));
    root.appendChild(node);

    QDomText value = document.createTextNode(nodeValues.at(i));
    node.appendChild(value);
}
```

The code looks pretty clear. Create an element, set its attribute and append
it to root. The 2nd block is used to set the value of that node.

To write the XML into file, open a QFile object, open it and flush the
document onto it.

```cpp
QFile xml("new-xml-file.xml");
xml.open(QIODevice::WriteOnly);
xml.write(document.toByteArray());
xml.close();
```

Here is the output.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<properties>
    <node type="user">minhaz</node>
    <node type="os">linux</node>
    <node type="version">3.2.0-37</node>
</properties>
```

That is enough for basic XML r/w actions. If you want to learn more or go
deeper, run Qt Assistant. They have really awesome and detailed documents out
there.

Cheers!
