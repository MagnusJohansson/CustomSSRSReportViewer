#Custom SQL Server Reporting Services ReportViewer.aspx page

##Introduction
If you ever had the need to add a clear / reset button to your standard SQL Server Reporting Services report viewer, here’s a way to do it. Normally when reports are displayed, they are piped through the ReportViewer.aspx page that comes with SSRS. This page hosts the Reporting Server host component, and adds text boxes, radio buttton etc. based on the number of parameters you have in your report.

##Disclaimer
To accomplish this, you have to modify the ReportViewer.aspx OOB file from SSRS, which is not supported and probably not even recommended by Microsoft. So you are on your own. 
This customization has so far only been tested on SSRS 2008.

##Installation
Backup your existing ReportViewer.aspx file before doing any modifications to it.
Edit it (or replace it completely with the one from here) and that should be it.