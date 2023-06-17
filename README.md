<!---
SPDX-License-Identifier: CC-BY-4.0

Copyright (c) 2023 Nelson Vieira

@author Nelson Vieira <2080511@student.uma.pt>
@license CC-BY-4.0 <https://creativecommons.org/licenses/by/4.0/legalcode.txt>
--->
# Master's Thesis on *Privacy Protection in Internet of Things Systems*

This repository is a monorepo of the master's thesis, it contains the preparation work of the thesis, the thesis itself and the associated software along with any documentation.

In part inspired by extreme openness, which I first came across on [Thang Luong's thesis](https://github.com/lmthang/thesis), and by the love of free and open source software I starting pushing this work here since I first started working on it. I hope this will be useful to someone, or at least this repository provides transparency to the whole process, as you can see every commit made.

Feel free to submit comments or feedback in the [`Issues` tab](https://github.com/nelson-vieira/masters-thesis/issues).

---

## Abstract

Internet of things (IoT) devices are everywhere, since the birth of ubiquitous computing that human every day life is envisioned containing millions of devices that control every aspect of our lives. Today we have smart cars, smart houses, smart cities, wearables among other things that use various types of devices and various types of networks to communicate. These devices create new ways of collecting and process personal data from users and non-users. Most end users are not even aware or have little control over the information that is being collected by these systems. This work takes an holistic approach to this problem by first doing a literature review, then conducting a survey to learn more about the general knowledge of the public, and finally, based on the information gathered, a system is proposed that gives users information about the devices that are nearby and how to protect the data that they do not want to share with these devices, this system is capable of detecting what type of devices are nearby, what kind of data is collected by these devices, show privacy choices to the user when it is possible to do so and what can be done to protect unwanted data from being collected.

## Application

The application developed for this thesis aims to give users a better understanding of IoT devices. This application displays information about IoT devices, like the type of information these devices collect and what privacy options are available.  
Users can add and edit IoT devices.

The application and any documentation related to it, like the software requirements specification, can be found in [`masters-thesis/app`](masters-thesis/app).

## License

The application in the `masters-thesis/app` directory is licensed under a [AGPL-3.0 license](LICENSE-APP), except in `masters-thesis/app/docs` directory.

All other code in this repository is licensed under the [CC-BY-4.0 license](LICENSE).

Copyright &copy; 2023 Nelson Vieira
