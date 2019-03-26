---
layout: post
title: "Samsung 840 PRO SSD Low IOPS Fix"
date: 2015-02-23 15:36:00
categories: SSD
---
I have been using Samsung 840 PRO SSD for the last few months. It is an amazing SSD with blazing speed and responsiveness. It takes 2-3 seconds to boot my Kubuntu or Windows system.

The disk works fine on Kubuntu. But on Windows it gives a little lack in performance. I didn't notice it cause I barely use Windows.

I used several benchmarking tools like [AS SSD Benchmark](http://alex-is.de/PHP/fusion/downloads.php?download_id=9), [Samsung Magician](http://www.samsung.com/global/business/semiconductor/minisite/SSD/global/html/support/downloads.html), [CrystalDiskMark](http://crystalmark.info/software/CrystalDiskMark/index-e.html) etc. All of them reported that my SSD is working at half of its expected performance. I couldn't understand why. Later I looked into the issue and found some amazing solutions. I am sharing my experience.

1. **Port**: Make sure that your SSD is connected to "Intel SATA III 6Gb/s" port, not regular SATA ports of your motherboard. If possible buy other SATA controller like Marvell's.
2. **SATA Mode**: Set SATA mode to AHCI. This makes the device hot swappable.
3. **4K Alignment**: This is very important. Partition your SSD with correct 4K alignment. Look [here](http://us.hardware.info/reviews/4583/4/how-to-copy-hdd-to-ssd-with-correct-4k-alignment-4k-alignment) for more information on 4K alignment and how it affects your performance.
4. **Partitioning Tool**: Avoid built in partitioning tools on Windows. I prefer [GParted](http://gparted.org/download.php).
5. **Drivers**: Don't ever forget to install correct and updated drivers for your board and controllers. Install Chipset driver, Rapid Storage driver, Management Engine driver and all.

After doing all these things properly I retested my SSD and got expected result. Sequential read and write rate reached upto 500MB/s. (Sorry for the choppy image)

<img class="img img-responsive" src="http://i.imgur.com/97Gm5aH.jpg" />

Samsung Magician also shows the similar result. IOPS is almost close to its expected result.

<img class="img img-responsive" src="http://i.imgur.com/WajqeuZ.jpg" />