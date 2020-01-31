$(document).ready(function() {
    console.log("defaultDue");
    dte = new Date();
    dtestr = dte.toISOString().slice(0,10);
    console.log(dtestr);
    Array.from(document.querySelectorAll('.new_issue #issue_due_date')).forEach(elt => {
        if (elt.value == "") {
            elt.value = dtestr;
        }
    })
});
 

