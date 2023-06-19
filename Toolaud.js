const notificationBubble = document.getElementById("notif_bubble");
const notificationBtn = document.getElementById("notif_btn");
const notifs = document.getElementById("notifs");
const toggle = document.getElementById("toggle_button");

notificationBtn.addEventListener("click", () => {
    if (notifs.hidden == true) {
        notifs.hidden = false;
    } else {
        notifs.hidden = true;
        hideTeated();
        if(toggle !== null){
          toggle.textContent = "Vaata kõiki teateid";
      }
    }
});

window.onload = function() {
    if (isTeatedVisible == false && toggle) { // Check if toggle button exists
        toggle.textContent = "Vaata kõiki teateid";
    }

    const urlParams = new URLSearchParams(window.location.search);
    const notifsState = urlParams.get('notifs_state');

    console.log(notifsState);
    
    notifs.hidden = true;
    hideTeated(); 

      var loetudCheckboxState = localStorage.getItem("loetudCheckboxState");
      var loetud2CheckboxState = localStorage.getItem("loetud2CheckboxState");

      console.log(notifsState);

      if (notifsState == "visible") { 
        console.log("test1");
        notifs.hidden = false;
        showTeated();
        toggle.textContent = "Vaata kõiki teateid";

        if (loetudCheckboxState === "checked") {
          console.log("notifstate visible, checkbox checked");
          hideTeated();
          notifs.hidden = false;
          toggle.textContent = "Peida";
        } else {
          notifs.hidden = true;
          console.log("notifstate visible, checkbox unchecked");
        }
        if (loetud2CheckboxState === "checked") {
          console.log("notifstate visible, checkbox type 2 checked");
          notifs.hidden = false;
          showTeated();
        }

    } else {
      console.log("notifstate hidden");
      notifs.hidden = true;
      hideTeated();
      
    }
};

function fetchParameter() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var notifications = JSON.parse(this.responseText);
    }
  };
  xhttp.open("GET", "path/to/your/php/file.php", true);
  xhttp.send();
}


function getParameterByName(name) {
  name = name.replace(/[\[\]]/g, '\\$&');
  var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
      results = regex.exec(location.search);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

$(document).ready(function () {
  $("#loetud").change(function () {
    if ($(this).is(":checked")) {
      localStorage.setItem("loetudCheckboxState", "checked");
      this.form.submit();
    } else {
      localStorage.setItem("loetudCheckboxState", "unchecked");
      $(this).prop("checked", false);
      setTimeout(function () {
        this.form.submit();
      }, 100);
    }
  });
});

  $(document).ready(function () {
    $(".loetud-checkbox").change(function () {
      if ($(this).is(":checked")) {
        localStorage.setItem("loetud2CheckboxState", "checked");
        this.form.submit();
      } else {
        localStorage.setItem("loetud2CheckboxState", "unchecked");
        $(this).prop("checked", false);
        setTimeout(function () {
          this.form.submit();
        }, 100);
      }
    });
  });

var isTeatedVisible = false;

function toggleTeated() {
    if (isTeatedVisible) {
        toggle.textContent = "Vaata kõiki teateid";
        hideTeated();
    } else {
        toggle.textContent = "Peida";
        showTeated();
    }
}

function hideTeated() {
    var teatedResult = document.getElementById("teated_result");
    var tabelid = document.querySelector(".grid-container");
    teatedResult.style.display = "none";
    isTeatedVisible = false;
    tabelid.style.marginTop = "20px";
}

function showTeated() {
    var teatedResult = document.getElementById("teated_result");
    var tabelid = document.querySelector(".grid-container");
    teatedResult.innerHTML = ''; 
    teatedResult.style.height = "0"; 
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            teatedResult.innerHTML = this.responseText;
            teatedResult.style.display = "block";
            teatedResult.style.height = "auto";
            isTeatedVisible = true;
            tabelid.style.marginTop = teatedResult.offsetHeight + 20 + "px";
        }
    };
    xhttp.open("GET", "Teated_koik.php?toggle=true", true);
    xhttp.send();
}

function fetchAllNewDataAndInsert(lastFetchedEntries, connHost, connUsername, connPassword, connDatabase) {
    var queryUrl = 'Teated_andmebaasi.php';
    var formData = new FormData();
    formData.append('lastFetchedEntries', JSON.stringify(lastFetchedEntries)); // Convert to JSON string
    formData.append('connHost', connHost);
    formData.append('connUsername', connUsername);
    formData.append('connPassword', connPassword);
    formData.append('connDatabase', connDatabase);

    fetch(queryUrl, {
        method: 'POST',
        body: formData
    })
    .then(function(response) {
        return response.json();
    })
    .then(function(data) {
        if (data.success) {
            var newLastFetchedEntries = data.lastFetchedEntries;
            fetchAllNewDataAndInsert(newLastFetchedEntries, connHost, connUsername, connPassword, connDatabase);
        } else {
            console.error('Error: ' + data.error);
        }
    })
    .catch(function(error) {
        console.error('Fetch Error:', error);
    });
}

function submitForm(teate_id) {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "Toolaud.php");
  
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "updateColumn[]");
    hiddenField.setAttribute("value", teate_id);
  
    form.appendChild(hiddenField);
  
    document.body.appendChild(form);
    form.submit();
}


document.getElementById('home_btn').addEventListener('click', function() {
    document.body.innerHTML = ''; // Clear the page contents
  
    setTimeout(function() {
      window.location.reload(); // Refresh the page 
    }, 50);
  });