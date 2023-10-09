<!---
SPDX-License-Identifier: CC-BY-4.0

Copyright (c) 2023 Nelson Vieira

@author Nelson Vieira <2080511@student.uma.pt>
@license CC-BY-4.0 <https://creativecommons.org/licenses/by/4.0/legalcode.txt>
--->
# Master's Thesis on *Privacy Protection in Internet of Things Systems*

This repository is a monorepo of the master's thesis, it contains the preparation work of the thesis, the thesis itself and the associated software along with any documentation.

Partly inspired by extreme openness, which I first came across on [Thang Luong's thesis](https://github.com/lmthang/thesis), and by the free and open source software (FOSS) principles, I started hosting this work here since I first started working on it. Hopefully this will be useful to someone. This repository at least provides transparency to the whole process, as anyone can see every commit made.

Feel free to submit comments or feedback in the [`Issues` tab](https://github.com/nelson-vieira/masters-thesis/issues).

---

## Abstract

Internet of Things (IoT) devices are everywhere, since the birth of ubiquitous computing, human every day life is expected to contain millions of devices that control every aspect of our lives. Today we have smart vehicles, smart houses, smart cities, wearables among other things that use various types of devices, and various types of networks to communicate. These devices create new ways of collecting and processing personal data from users, and non-users. Most end users are not even aware or have little control over the information that is being collected by these systems. This work takes an holistic approach to this problem by first conducting a literature review to compile current solutions, challenges and future research opportunities. Then conducting a survey to learn more about the general knowledge of individuals about privacy, IoT and online habits, and finally, based on the information gathered, a mobile application is proposed that gives users information about nearby devices, and how to protect the data that they do not want to share with them. User testing revealed that participants valued having access to more information about privacy related terms. This application is capable of detecting what type of devices are nearby, what kind of data is collected by these devices, and displaying privacy options to the user, when it is possible to do so, with the goal of providing individuals a tool to make informed decisions about their private data.

## Application

The application developed for this thesis aims to give users a better understanding of IoT devices. This application displays information about IoT devices, like the type of information these devices collect and what privacy options are available.  
Users can add and edit IoT devices.

The application and any documentation related to it, like the software requirements specification, can be found in [`masters-thesis/app`](masters-thesis/app).

## License

The application in the `masters-thesis/app` directory is licensed under a [AGPL-3.0 license](LICENSE-APP), except in `masters-thesis/app/docs` directory.

All other code in this repository is licensed under the [CC-BY-4.0 license](LICENSE).

Copyright &copy; 2023 Nelson Vieira
