#Custom SQL Server Reporting Services ReportViewer.aspx page

##Introduction
Blog post can be [found here] (http://insomniacgeek.com/how-to-add-a-clear-button-to-sql-server-reporting-services-ssrs/ "InsomniacGeek")  

If you ever had the need to add a clear / reset button to your standard SQL Server Reporting Services report viewer, here’s a way to do it. Normally when reports are displayed, they are piped through the ReportViewer.aspx page that comes with SSRS. This page hosts the Reporting Server host component, and adds text boxes, radio buttton etc. based on the number of parameters you have in your report.

![Report Viewer Page with Clear Button](https://github.com/MagnusJohansson/CustomSSRSReportViewer/raw/master/images/ReportViewerWithClearButton.png)

This customized page will add this button that will clear any textboxes in the parameter field.

You can’t simply replace this file with your own custom page, because SSRS has HTTP handlers installed that prevents any other file to be rendered except the ReportViewer.aspx page.
So how to add a clear button to clear the text boxes? One way to do it is to modify the OOB ReportViewer.aspx page by injecting some javascript that does this for us. Initially I wanted to use jQuery, but again, the HTTP handler prohibits us from accessing the external .js file. Back to plain old Javascript it is.
Essentially, we just need to find the container that holds the View Report button, and add our custom button.

In the body tag, add a page onload event handler:  
```
<body style="margin: 0px; overflow: auto" onload="addClearButton();">
```

And then add javascript that does the magic:

```
<script type="text/javascript">
document.getElementsByClassName = function(cl) {
    var retnode = [];
    var myclass = new RegExp('\\b'+cl+'\\b');
    var elem = this.getElementsByTagName('*');
    for (var i = 0; i < elem.length; i++) {
        var classes = elem[i].className;
        if (myclass.test(classes)) retnode.push(elem[i]);
    }
    return retnode;
};

function addClearButton(){
    var inputs = document.getElementsByClassName('SubmitButtonCell');

    // can't find the cell, return
    if (inputs.length<1)
        return;

    // create a button
    var clearButton = document.createElement("input");
    clearButton.type = "button";
    clearButton.value = "Clear";
    clearButton.name = "btnClear";
    clearButton.style.width = "100%";

    // add clear text boxes functionality to the onclick event
    clearButton.onclick = function (){
        var textBoxes = document.getElementsByTagName("input");
        for (var i=0;i<textBoxes.length;i++){
        if (textBoxes[i].getAttribute("type")=="text"){
          textBoxes[i].value ="";
          }
        }
    };

    // find the relevant cells
    var tdSubmitButtonCell = inputs[0];

    // find the child table
    var table = tdSubmitButtonCell.childNodes[0];
    var lastRow = table.rows.length;
    var row = table.insertRow(lastRow);
    var cellLeft = row.insertCell(0);

    // add the clear button
    cellLeft.appendChild(clearButton);
  }

</script>
```

##Disclaimer
To accomplish this, you have to modify the ReportViewer.aspx OOB file from SSRS, which is not supported and probably not even recommended by Microsoft. So you are on your own. 
This customization has so far only been tested on SSRS 2008.

##Installation
Backup your existing ReportViewer.aspx file before doing any modifications to it.
Edit it (or replace it completely with the one from here) and that should be it.
The file is by default installed at:
```
C:\Program Files\Microsoft SQL Server\MSRS10.MSSQLSERVER\Reporting Services\ReportServer\Pages
```  
But it of course depends on where you installed SSRS.

##License
This software is publish under the MIT License
 
> Copyright (C) 2012 Magnus Johanssson mailto:insomniacgeek@insomniacgeek.com
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
