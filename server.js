const express = require("express");

// We use `process.env.PORT` so that it works
//  on Heroku as well, but fallback to 4000
//  for developing locally
const PORT = process.env.PORT || 4000;
const HOST = "0.0.0.0";
// BTW, we can similarly use `process.env.DATABASE_URL`
//  if we want to use a Heroku attached Postgres DB

const app = express();

app.get("/", (req, res) => {
  res.send(`Hello from inside a Docker container!`);
});

app.listen(PORT, HOST, () => {
  console.log(`Running on http://${HOST}:${PORT}`);
});
