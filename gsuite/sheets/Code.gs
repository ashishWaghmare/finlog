function myFunction() {
  Browser.msgBox("Hello World!");
  insertRows();
}

function insertRows() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var date = new Date();
  for (var i=0; i < 10; i++) {
         ss.appendRow([date,200, 'script added']);
  }
}
