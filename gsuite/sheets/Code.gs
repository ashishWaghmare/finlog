function doGet(e){
  myFunction();
}

function doPost(e) {
  myFunction();
}

function myFunction() {
  Browser.msgBox("Hello World!");
  insertRows();
}

function insertRows() {
  var ss = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("test");
  var date = new Date();
  for (var i=0; i < 10; i++) {
         ss.appendRow([date,200, 'script added']);
  }
}
