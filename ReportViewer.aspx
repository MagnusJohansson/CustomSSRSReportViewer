<%@ Register TagPrefix="RS" Namespace="Microsoft.ReportingServices.WebServer" Assembly="ReportingServicesWebServer" %>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Microsoft.ReportingServices.WebServer.ReportViewerPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head id="headID" runat="server">
  <title>Report Viewer</title>

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
