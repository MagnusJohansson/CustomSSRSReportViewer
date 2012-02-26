<%@ Register TagPrefix="RS" Namespace="Microsoft.ReportingServices.WebServer" Assembly="ReportingServicesWebServer" %>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Microsoft.ReportingServices.WebServer.ReportViewerPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head id="headID" runat="server">
  <title>Report Viewer</title>

  <!--
Copyright (C) 2012 Magnus Johanssson mailto:insomniacgeek@insomniacgeek.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
-->

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
 </head>
 <body style="margin: 0px; overflow: auto" onload="addClearButton();">
  <form style="width:100%;height:100%" runat="server" ID="ReportViewerForm">
   <RS:ReportViewerHost ID="ReportViewerControl" runat="server" />
  </form>
 </body>
</html>
