const { error } = require("console");
const express = require("express");
const mysql = require("mysql");
const path = require("path");
const bodyParser = require("body-parser");
const app = express();

const pool = mysql.createPool({
  host: "localhost", // database host
  user: "root", // database username
  password: "Snehilk31", // database password
  database: "ayushinventorydb", // database name
});

app.set("view engine", "ejs");

app.use(express.static(path.join(__dirname, "public")));

app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.static("public"));

app.get("/", (req, res) => {
  res.render("homepage");
});

app.get("/login", (req, res) => {
  res.render("index");
});

// app.get("/details", (req, res) => {
//   pool.getConnection((err, connection) => {
//     if (err) throw err;
//     connection.query("SELECT * FROM clients", (err, rows) => {
//       connection.release();
//       if (!err) {
//         res.send({
//           rows: rows,
//         });
//       } else {
//         console.log(err);
//       }
//     });
//   });
// });

app.get("/details", (req, res) => {
  res.render("enter");
});

app.post("/details", (req, res) => {
  const selectedTableName = req.body.tableName;

  pool.getConnection((err, connection) => {
    if (err) throw error;
    connection.query(`SELECT * FROM ${selectedTableName}`, (err, result) => {
      if (err) {
        console.error("Error fetching data from MySQL: " + err.stack);
        res.send("Error fetching data from MySQL");
        return;
      }

      // Assuming the result object has column and data information
      const tableData = {
        columns: Object.keys(result[0]),
        rows: result.map((row) => Object.values(row)),
      };

      // Rendering the table data on a new page
      res.send(`
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${selectedTableName} Table</title>
                <style>
                    /* Add your CSS styling here if needed */
                    body {
                        font-family: Arial, sans-serif;
                        margin: 0;
                        padding: 20px;
                    }
  
                    table {
                        border-collapse: collapse;
                        width: 100%;
                    }
  
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                        text-align: left;
                    }
  
                    th {
                        background-color: #4CAF50;
                        color: white;
                    }
                </style>
            </head>
            <body>
                <h2>${selectedTableName} Table</h2>
                <table>
                    <thead>
                        <tr>
                            ${tableData.columns
                              .map((column) => `<th>${column}</th>`)
                              .join("")}
                        </tr>
                    </thead>
                    <tbody>
                        ${tableData.rows
                          .map(
                            (row) =>
                              `<tr>${row
                                .map((data) => `<td>${data}</td>`)
                                .join("")}</tr>`
                          )
                          .join("")}
                    </tbody>
                </table>
            </body>
            </html>
        `);
    });
  });
  // Fetch dynamic table columns and data from MySQL
});

app.listen(3000, () => {
  console.log("Server started on port 3000");
});
