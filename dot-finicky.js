// ~/.finicky.js

module.exports = {
  defaultBrowser: "Orion",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" }
    }
  ],
  handlers: [
    {
      // Open apple.com and example.org urls in Safari
      match: ["apple.com/*", "example.org/*", "google.com/search"],
      browser: "Orion"
    },
    {
      // Open any url that includes the string "workplace" in Firefox
      match: /workplace/,
      browser: "Firefox"
    },
    {
      // Open google.com and *.google.com urls elsewhere
      match: [
        //"google.com/*", // match google.com urls
        "meet.google.com/*", // match google.com subdomains
        "calendar.google.com",
        "gmail.com",
        "chrome.google.com",
        "docs.google.com/forms/*"
      ],
      browser: "Safari"
    }
  ]
};