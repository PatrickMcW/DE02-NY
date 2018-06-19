# <a id="top">Patrick McWilliams DE-02 Case Study</a>

## Table of Contents

[Section 2.1.1](#211) Java and RDBMS </br>
[2.1.1a](#211a) Core Java</br>
[2.1.1b](#211b) RDBMS/MySQL</br>
[Section 2.2.1](#221) Hadoop/HDFS/Data Warehousing</br>
[Section 2.2.2](#222) Hive and Partition</br>
[Section 2.2.3](#223) Oozie - all data</br>
[Section 2.2.4](#224) Oozie - incremental data</br>
[Section 2.2.5](#225) Visualization</br>
[Section 2.2.6](#226) Pig (optional)</br>

---

NOTE: the `./` notation in filepaths below is meant to indicate the directory you have downloaded all the project folders to. As an example, if you downloaded this project to `C:\Users\Students\Downloads\PatrickM` then the notation `./2.1/2.1_java_program.zip` would mean the zip file could be found at `C:\Users\Students\Downloads\PatrickM\2.1\2.1_java_program.zip`

(windows explorer seems to be compatible with linux directory/folder delimiter)

---

### <a id="211">2.1.1</a> `Java and RDBMS`
---

  #### <a id="211a">2.1.1a</a> `Core Java`

  Java program to run specific queries with select user-defined inputs. File-writing capable based on teacher suggestion, though this is not used in further sections of the case study.
</br>
  Follow program prompts for details on input. When updating a customer’s information, some string/varchar column values longer than 30 characters will break the program.

* Relevant files:

	`./2.1/2.1_java_program.zip`

  **Extract** to your preferred location.

  #### In eclipse:
    **Update** ‘/CaseStudy/src/com/cdw/resources/db.properties’ to match your database connection values, user/pass, etc (which is determined in the following MySQL section)
</br>
    **Run** ‘/CaseStudy/src/com/cdw/runner/ChooseRunner.java’ to run the program.(Running from any location should only run this file anyway)
---
  ### <a id="211b">2.1.1b</a> `RDBMS/MySQL`
* File path of exported tables is:
		`./2.1/2.1_cdw_sapp_tables.zip`
 **Extract** and run files to create DB and insert data
---
---
### <a id="221">2.2.1</a> `Hadoop/HDFS/Data Warehousing`
* Sqoop scripts/commands found in:
		`./2.2.1/`
</br>
  Working directory in Hadoop/HDFS will be:
  `/Credit_Card_System/`
  based on instruction in Functional Requirement doc
</br>
  See above sqoop commands for subdirectories/target-directories
---
### <a id="222">2.2.2</a> `Hive and Partition`
* Hive definitions found at:
		`./2.2.2/`
</br>
* **Run** cdw_sapp_create_db first, then remaining commands/files can be run in any order. I ran these commands through Ambari Hive worksheets, but I would expect them to work from the command line as well. It may be necessary to select the CDW_SAPP DB from the hive DB dropdown, depending on how you run the commands/scripts/creates.
---
### <a id="223">2.2.3</a> `Oozie - all data`
* Filepath for this section found at:
		`./2.2.3/`
  The tables defined in 2.2.2 can be used here, or you can **run** the hive commands found in:
      `./2.2.3/hive/`
    to (re)create the tables necessary for this section.
</br>
	**Copy** the coordinator.xml and workflow.xml files in:
      `./2.2.3/oozie/`
    to HDFS:
      `/Credit_Card_System/oozie/223/`
	In the VM running the HDFS, **run** the sqoop commands found in the files at:
      `./2.2.3/sqoop`
  to create the sqoop jobs for this section (2.2.3).
</br>
	**Copy** the jobs.properties file to a directory on the VM running the HDFS. Any directory can be used, I would suggest something like:
      `/root/Documents/PatrickM/223/`
	In that directory, run
		  `oozie job -oozie http://localhost:11000/oozie -config job.properties –run`
</br>
  **Record** this job ID someone so we can kill it before moving on to the next section (2.2.4).
</br>
  * **Note:** while this dataset has no repeated SSNs, the primary key of the customer table is a composite key, which sqoop does not support for merge-key operations. I am not sure what an appropriate split column would be, but to ensure uniqueness, it should be one of the two composite key columns. This feels like it would be an excessive amount of splitting, however.
</br>

* Before starting 2.2.4, **kill** the job from 2.2.3. The particular job ID will be different based on your oozie environment/history:
		  `oozie job -oozie http://localhost:11000/oozie -kill JOB_ID_FROM_223_HERE`
</br>
  **Delete** table folders on HDFS under the
      `/Credit_Card_System/`
</br>
  directory. We will be re-defining tables to remove the partition for this next part(2.2.4), as instructed by the instructor team.
---
### <a id="224">2.2.4</a> `Oozie - incremental data`
**Check** that coordinator job from 2.2.3 has been killed before proceeding.
We should have a fresh start with empty tables/directories to work from and no jobs running.

* Filepath for this section found at:
    `./2.2.4/`
</br>
  **Run** the hive commands found in:
      `./2.2.4/hive`
  to create the tables necessary for this section.
</br>
  The cdw_all_defs.hql file can be run in one Ambari Hive worksheet. The first three lines of that file drop and recreate the database. This is optional as deleting the table folders at the end of 2.2.3 should give us a blank-enough slate to work from. If not running these commands, simply remove them from the hive worksheet.
</br>
  **Copy** the coordinator.xml and workflow.xml files in the above to HDFS:
      `/Credit_Card_System/oozie/224/`
	In the VM running the HDFS, run the commands found in the files at:
      `./2.2.4/sqoop`
  to create the sqoop jobs for this section (2.2.3).
</br>
	**Copy** the jobs.properties file to a directory on the VM running the HDFS. Any directory can be used, I would suggest something like:
      `/root/Documents/PatrickM/224/`
  In that directory, run
		`oozie job -oozie http://localhost:11000/oozie -config job.properties –run`
  Record this job ID someone so we can kill it later.
</br>
	* **Note:** incremental append from the CDW_SAPP_CREDITCARD is using TRANSACTION_ID as that should be chronological with “new” data and not the likely randomly generated day/month numbers in the case study data set. An alternative would be to add the “timeid” column that eventually exists in Hive to the MySQL version of the DB and then use incremental lastmodified based on that DATE column.
</br>

* To prevent this job from running until 2025, kill the coordinator at your earliest convenience with:
	   `oozie job -oozie http://localhost:11000/oozie -kill JOB_ID_FROM_224_HERE`

---
### <a id="225">2.2.5</a> `Visualization`
* Visualization word doc, containing queries and their visualization screenshots, are found at:
    `./2.2.5/`
---
### <a id="226">2.2.6</a> `Pig (optional)`
* Pig scripts found at:
  `./2.2.6/`
</br>  
  Scripts are found between the `# start of script` and `# end of script` lines in each section.
</br>
  A description of what each script is intended to do is located after the script and preceded by a \# character.
</br>
  Each script's section is separated by a line of \= signs.
---
[top](#top)
