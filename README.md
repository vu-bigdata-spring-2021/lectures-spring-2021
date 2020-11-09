# Lectures - outline

**This lecture outline is still a draft based on the last spring lecture. But you can look at the past outline here**

## Spring 2020 

# Table of Conents

- [Topics in Big Data](#topics-in-big-data)
  * [Introduction](#introduction)
  * [Infrastructure](#infrastructure)
    + [Examples](#examples)
  * [Instructor](#instructor)
    + [Teaching Assistant](#teaching-assistant)
    + [Graders](#graders)
  * [Course Expectation](#course-expectation)
  * [Reading Material](#reading-material)
  * [Topics to be covered](#topics-to-be-covered)
  * [Exams, Quizzes, Assignments and projects](#exams--quizzes--assignments-and-projects)
  * [No collaborations unless explicitly permitted.](#no-collaborations-unless-explicitly-permitted)
  * [Evaluation](#evaluation)
  * [Grading Criteria](#grading-criteria)
  * [Course Policies](#course-policies)
  * [Letter Grade Distribution](#letter-grade-distribution)
  * [Disability Statement](#disability-statement)
  * [Emergency Evacuation Plan](#emergency-evacuation-plan)


# Topics in Big Data


## Introduction

The goal of this class is to cover topics in Big Data. The focus will be on principles and practices of data storage, data modeling techniques, data processing and querying, data analytics and applications of machine learning using these systems. We will learn about application of these concepts on large scale urban analytics in cities. To see an example where we really apply these techniques visit the following sites and take a look at the dashboards.

 * https://smarttransit.ai/
 * https://statresp.ai
 

## Infrastructure

We will use google colab, AWS and github. Please see [infrastructure.md](infrastructure.md)

## Instructor

Abhishek Dubey `(first name . last name at vanderbilt.edu)`

My research focus is on application of big data and machine learning for creating large scale social cyber-physical systems such as transportation networks. For more details visit my group project page. https://scope-lab-vu.github.io/

**Contact** We will use brightspace for communication. You can also create issues on github to point to any specific problem with an example or assignment. 

**Computation Resources** We will use AWS for computational resources. 

**Office Hours** TBD

I am also available by appointment as required. Send me an email if you need to meet with me outside the office hours.

### Teaching Assistant 

TBF
### Graders

- TBD

## Course Expectation

In the course we will be heavily using Python for programming excercises and analysis. We will also be using google collaboratory and Amazon Web Services. Knowledge of python is required. You are also expected to know how to use github and clone repositories.


see the file [infrastructure.md](infrastructure.md)

## Reading Material
Most lectures I will assign reading material. You are expected to read it before the next class. The reading material will be available in the linked folder. See [01-introduction/reading](01-introduction/reading) for example.


## Topics to be covered
- [Applications of Big Data](https://vanderbilt365-my.sharepoint.com/:p:/g/personal/abhishek_dubey_vanderbilt_edu/EQS_UWKzCTpHlRhTARG76YYBYtKHV3v9-K1454_yYH7y1w?e=qWb0je)
- [History of Database and Big Data Systems](02-history)
- Big Data Infrastructure
  - [Understanding IoT and Cloud Computing](02a-IoT): 
  - [Understanding the database anatomy and optimizing access](03-anatomy_and_access)  
  - [Concurrent Access and Online transactions: Paxos, Raft and Consensus](04_concurrentaccess) 
  - [Understanding NoSQL: Big Table, MongoDB, Dynamo DB Column storage vs Row Storage](05_nosql) 
 - Computation Models and Big Data Processing (Batch Data) 
   - Classical Workflow Systems (covered as an overview in class). See the [following paper](https://pegasus.isi.edu/wordpress/wp-content/papercite-data/pdf/deelman-fgcs-2015.pdf) for an example. [Here is another paper](https://www.isis.vanderbilt.edu/sites/default/files/WorkflowML.pdf) that provides a good formal definition of a workflow system.
   - [Map Reduce and HDFS](06_mapreduce_and_spark)  
   - [Spark and RDD](06_mapreduce_and_spark)  
   - [Pulsar](07_pulsar_kafka_zookeeper) - Streaming Data Collection and Management (Pub/Sub systems)
   - [Storm and Heron](08_streamprocessing)
- Analytics
  - [Machine Learning including clustering](09_machinelearning) - overview of machine learning
  - [Link Analysis and Page Rank](06_mapreduce_and_spark/02-motivatingspark-PageRank.pptx)
 - Practical Applications
   - [City Scooter Data Analysis](10_practicalApplications/BigDatainPractice.pdf)
   - [City Accident Data Analysis](10_practicalApplications/BigDatainPractice.pdf)
   - [Transit Energy systems](10_practicalApplications/BigDatainPractice.pdf)
 - [Time series Databases](11_timeseries_db)
 - Misc topics if time permits
   - Memcached
   - Dremel
   - SparkML
 - [Project ideas - not applicable for this semster](12_projectideas)
  
 ## Exams, Quizzes, Assignments and projects
 
- 3 take home quizzes.
- 5 programming assignments. 
- Midterm
- The final exam will be replaced by a final project and summary report to be presented and submitted by the end of the day of the final class.  

## No collaborations unless explicitly permitted.

The Vanderbilt Honor Code will govern work done. ANY VIOLATIONS WILL RESULT in the case to be reported to the honor council. You are welcome to refer to the online sources for your assignments. However, you must not copy the code and must provide citation of the source of inspiration. All work will be submitted via github.

## Evaluation

The following grading criteria are tentative and are
subject to change. Each graded item in this course will be assigned a
certain number of points. Your final grade will be computed as the total
number of points you achieved divided by the number of points possible.
The instructor reserves the right to apply a curve to the final result.


## Grading Criteria

| Category        | Percentage  |
| ------------- |:-------------:| 
| Programming Assignments    | 40% | 
| Quizzes          | 20% |
| Mid Term Exam | 20%|
| Final Project       | 20% |



## Course Policies

Submissions will be due by midnight on the day mentioned in the assignment and homework description. Late submissions will be penalized with an automatic **20 percent penalty per day** (applied relative to the graded score for the submission).

## Letter Grade Distribution

| Score        | Letter  |
| ------------- |:-------------:| 
| >= 93.00    |   A      |
| 90.00 - 92.99  |  A-   |
| 87.00 - 89.99 | B+     |
| 83.00 - 86.99  | B     |
| 80.00 - 82.99  | B-     |
| 77.00 - 79.99  | C+  |
| 73.00 - 76.99  | C  |
| 70.00 - 72.99  | C-  |
| 67.00 - 69.99  | D+  |
| 63.00 - 66.99  | D  |
| 60.00 - 62.99  | D-  |
| <= 59.99   |  F  |


## Disability Statement

Vanderbilt is committed to equal opportunity
for students with disabilities. If you have a physical or learning
disability, you should ask the Opportunity Development Center to assist
you in identifying yourself to your instructors as having a disability,
so that appropriate accommodation may be provided. Without notification,
your instructors assume that you have no disabilities or seek no
accommodation.

## Emergency Evacuation Plan

 In the event of a fire or other emergency,
the occupants of this class should collect their coats and personal
belongings and leave the building using the stairs. VANDERBILT
UNIVERSITY POLICY FORBIDS REENTRY TO A BUILDING IN WHICH AN ALARM HAS
OCCURRED WITHOUT AUTHORIZATION BY VANDERBILT SECURITY. If, in
consequence of a disability, you anticipate the need for assistance,
please discuss that need with the instructors.

If a tornado siren is heard, please go to the nearest interior hallway or interior rooms away from windows.


