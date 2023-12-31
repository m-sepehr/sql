<!DOCTYPE html>
<html>
<head>
    <title>Education Personnel Status Tracking System (EPSTS)</title>
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <!-- CodeMirror CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/codemirror.min.css">

    <!-- SQL syntax highlighting theme (you can choose another theme if you want) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/theme/dracula.min.css">

    <!-- CodeMirror JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/codemirror.min.js"></script>

    <!-- SQL mode for CodeMirror -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/mode/sql/sql.min.js"></script>

    <!-- placeholder.js for CodeMirror -->
    <script src="https://codemirror.net/5/addon/display/placeholder.js"></script>

    <style>
        body {
            font-family: Helvetica, sans-serif;
            background-color: #d0e4f5; /* Light blue background color */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        #container {
            width: 70%;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        textarea {
            width: 95%;
            margin: 0 auto; /* Center the textarea */
            height: 200px;
            padding: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }
        /* Adjusting the overall CodeMirror container */
        .CodeMirror {
            font-family: 'Courier';
            font-size: 18px;
            border: 1px solid #ccc;
            border-radius: 5px;
            height: 200px;
        }

        /* Adjusting the background color of active line */
        .CodeMirror-focused .CodeMirror-line::selection, .CodeMirror-line::-moz-selection, .CodeMirror-line > span::-moz-selection, .CodeMirror-line > span > span::-moz-selection {
            background-color: #d9f1ff;
        }

        /* Adjusting the color of the text */
        .CodeMirror-line, .CodeMirror-pre {
            color: #333; /* Dark text color */
        }

        /* Adjusting the gutter (line numbers) */
        .CodeMirror-gutters {
            border-right: 1px solid #ddd;
        }

        .CodeMirror-linenumber {
            color: #888;
        }
        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px; /* Add some margin at the top */
            flex-direction: row; /* Align buttons horizontally */
        }
        button {
            display: block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0px 10px; /* Add some margin between buttons */
            margin-bottom: 15px; /* Add margin at the bottom */
        }
        button:hover {
            background-color: #0056b3;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f7f7f7;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        #clearButton {
            background-color: #dc3545; /* Red background color */
        }
        #exportToCSV {
            background-color: #28a745; /* Green background color */
        }
        #results {
            max-height: 60vh; /* Adjust the maximum height as needed */
            overflow-y: auto;
        }
        #resultsList th {
            position: sticky;
            top: 0;
            background-color: #f2f2f2;
            z-index: 1;
            
        }
        #headerRow {
            position: sticky;
            top: 0;
            background-color: #f2f2f2;
            z-index: 1;  
        }
    </style>
</head>
<body>
    <div id="container">
        <h1>Education Personnel Status Tracking System (EPSTS)</h1>
        <form method="post" action="" onsubmit="return validateForm();">
                <div id="sqlEditor"></div>
                <div class="buttons"> <!-- Wrap buttons in a container div -->
                    <button type="submit">Execute</button>
                    <button type="button" id="clearButton">Clear Results</button>
                    <button type="button" id="exportToCSV">Export to CSV</button>
                </div>
        </form>
        <div id="results">
            <table id="resultList">
                <?php
                    if ($_SERVER["REQUEST_METHOD"] == "POST") {
                        $sql = $_POST["sqlQuery"];
                        $servername = "mdc353.encs.concordia.ca";
                        $username = "mdc353_1";
                        $password = "0705dtbs";
                        $dbname = "mdc353_1";

                        $conn = new mysqli($servername, $username, $password, $dbname);
                        if ($conn->connect_error) {
                            die("Connection failed: " . $conn->connect_error);
                        }

                        $result = $conn->query($sql);

                        if ($result !== false) {
                            
                            if (strtolower(substr(trim($sql), 0, 6)) === 'insert') {
                                $affected_rows = $conn->affected_rows;
                                echo "<div style='color: green; text-align: center; margin-bottom: 20px;'><b>{$affected_rows} row(s) successfully inserted.</b></div>";
                            } elseif (strtolower(substr(trim($sql), 0, 6)) === 'delete') {
                                $affected_rows = $conn->affected_rows;
                                echo "<div style='color: red; text-align: center; margin-bottom: 20px;'><b>{$affected_rows} row(s) successfully deleted.</b></div>";
                            } elseif (strtolower(substr(trim($sql), 0, 6)) === 'update') {
                                $affected_rows = $conn->affected_rows;
                                echo "<div style='color: orange; text-align: center; margin-bottom: 20px;'><b>{$affected_rows} row(s) successfully updated.</b></div>";
                            } elseif(strtolower(substr(trim($sql), 0, 6)) === 'select') {
                                $num_rows = $result->num_rows; // Get number of retrieved rows
                                echo "<div style='color: blue; text-align: center; margin-bottom: 20px;'><b>{$num_rows} row(s) retrieved.</b></div>";
                     
                                echo '<div style="text-align: center;">';
                                echo '<table id="dataResults" style="border-collapse: collapse; width: 90%; margin: 0 auto;">';
                    
                                // Display attribute names in bold (header row)
                                $field_names = $result->fetch_fields();
                                echo "<tr id='headerRow'>";
                                foreach ($field_names as $field) {
                                    echo "<th style='border: 1px solid #ddd; padding: 8px; background-color: #f2f2f2;'><b>" . htmlspecialchars($field->name) . "</b></th>";
                                }
                                echo "</tr>";
                    
                                // Display data rows
                                while ($row = $result->fetch_assoc()) {
                                    echo "<tr>";
                                    foreach ($row as $value) {
                                        echo "<td style='border: 1px solid #ddd; padding: 8px;'>" . htmlspecialchars($value) . "</td>";
                                    }
                                    echo "</tr>";
                                }
                    
                                echo '</table>';
                                echo '</div>';
                            } 
                        } else {
                            echo "Error: " . $sql . "<br>" . $conn->error;
                        }
                        
                        $conn->close();
                    }
                    ?>
            </table>
        </div>
    </div>
    <script>

        // JavaScript to validate form
        function validateForm() {
        if (editor.getValue().trim() === "") {
            alert('Please enter an SQL query!');  // Display an alert or any other form of notification
            return false;  // This will prevent the form from submitting
        }
            return true;  // This will allow the form to submit
        }


        // JavaScript to clear results
        document.getElementById("clearButton").addEventListener("click", function() {
            document.getElementById("results").innerHTML = ""; // Clear the content
        });

        // JavaScript to export table data to CSV file
        document.getElementById("exportToCSV").addEventListener("click", function() {
            let dataArr = [];
            let rows = document.querySelectorAll("#dataResults tr");

            if (rows.length === 0) {
                alert("There is no data to export.");
                return;
            }

        for (let i = 0; i < rows.length; i++) {
            let row = [], cols = rows[i].querySelectorAll("td, th");
            
            for (let j = 0; j < cols.length; j++) {
                let value = cols[j].innerText;
                row.push('"' + value.replace(/"/g, '""') + '"'); // escape double quotes
            }

            dataArr.push(row.join(","));
        }

        let csvData = dataArr.join("\n");
        let blob = new Blob([csvData], { type: 'text/csv' });
        let url = window.URL.createObjectURL(blob);

        let a = document.createElement("a");
        a.style.display = "none";
        a.href = url;
        a.download = "export.csv";

        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
    });


    // Initializing CodeMirror
    var editor = CodeMirror(document.getElementById("sqlEditor"), {
        mode: "text/x-sql",
        theme: "default",
        lineNumbers: true,
        autofocus: true,
        lineWrapping: true,
        placeholder: "SELECT * FROM ..." // This line adds placeholder text
    });


    // Before the form is submitted, populate the actual textarea with the contents of the CodeMirror editor
    document.querySelector('form').addEventListener('submit', function() {
    var sqlContent = editor.getValue();
    var hiddenTextarea = document.createElement('textarea');
    hiddenTextarea.name = "sqlQuery";
    hiddenTextarea.style.display = "none";
    hiddenTextarea.textContent = sqlContent;
    this.appendChild(hiddenTextarea);
});

    </script>
</body>
</html>
