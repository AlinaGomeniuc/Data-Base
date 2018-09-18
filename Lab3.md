## Databases Laboratory Work #3

## Tables creation and modification in SQL Server Management Studio

### Objective:
- Ability to create, rename and update a table
- Constraints
- Distinguish diferent data types
- Create a database diagram
- Do a backup to created database

### Tasks:
1. Which of the below numbers can be introduced in a field of DECIMAL(4,1) type?
a)16.2  b)116.2  c)16.21  d)1116.2  e)1116.21

2. [Col1] from the table is of type INT and [Col2] if of type DECIMAL(2,1)

       |Tabel| Col1 | Col2 | Col 3|
       |-----|------|------|------|
             |  1   |  1.0 |      |
             |  2   |  1.0 |      |
             
   What data type should be [Col3] if we want to process [Col1]* [Col2] ?
   
3. Create a new database called **Universitate** with defult properties. Create 5 tables : **_Discipline_** , **_Studenti_**, 
   **_Studenti_reusita_**, **_Profesori_**, **_Grupe_**). Show the database diagram. Do the backup.
   
   ### Solutions:
   #### For task nr.1:
      DECIMAL(P[,S]) data type is used to preserve exact decimal numbers. Parameter P represents the total number of digits that
      the field may contain. S represent the number of digits after decimal point. 
      In our case (4,1), 4 represent the nr. of total digits and 1 the nr. of digits after decimal point. So, the number that
      satisfies this conditions is : **116.2**.
  
  #### For task nr.2:
     
      In case we want to process [Col1]*[Col2], taking into account only this 4 numbers, than [Col3] should 
      be of type DECIMAL(2,1). If we're taking into account  the maximal values that INT and DECIMAL(2,1) can
      have, then [Col3]should be of type DECIMAL(12,1), because max of INT is 2.147.483.647 and max of
      DECIMAL(2,1)is 9.9.So, the result is 2 126 008 810 5.3.
      
  #### For task nr.3:   
  <img src="images/VirtualBox_Alina_18_09_2018_19_03_03.png " width= '500'>
  <img src="images/VirtualBox_Alina_18_09_2018_19_05_22.png " width= '500'>
  <img src="images/VirtualBox_Alina_18_09_2018_21_35_18.png " width= '500'>
  <img src="images/VirtualBox_Alina_18_09_2018_21_45_35.png " width= '500'>
  <img src="images/VirtualBox_Alina_18_09_2018_21_53_01.png " width= '500'>
  <img src="images/VirtualBox_Alina_18_09_2018_21_47_57.png " width= '500'>
  <img src="images/VirtualBox_Alina_18_09_2018_20_31_07.png " width= '500'>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
