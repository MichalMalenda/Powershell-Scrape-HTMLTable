# Powershell-Scrape-HTMLTable
 
Just going based off the example html might not be enough so to simply explain the script.
* The script goes through the saved version of the website and for the first **<table** tag we start collecting this and the next lines;
* We keep doing that until the moment we encounter another **<table** marker or the **</table>**;
* If it's another open table marker we mark it as exception so that the next time we encounter close table tag we won't stop collecting the lines;
* This means that if we have 2 levels of sub-tables this won't be working properly but as per example 1 level of sub table works fine;
* If what we encounter is a proper close table tag the script stops collecting the lines until the next open table tag;
* Script then exports the results in one file that we can use.

NOTE - It's worth mentioning why we use close table tag with a closure bracket but we only use open table tag with one bracket. Usually open table tag contains some styles or another ref to something else so to make this as universal as possible I've made sure to go off the start of the tag. 
