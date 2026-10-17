const express = require('express');
const app = express();
const PORT = process.env.PORT || 8998;

// Middleware to parse query parameters
app.use(express.urlencoded({ extended: true }));

const googleSearch = (q) => `https://www.google.com/search?q=${encodeURIComponent(q)}`;

// Command handlers per mode. Each returns a URL, or undefined to fall back to Google search.
const handlers = {
  ritp(command, query, searchQuery) {
    switch (command) {
      case 'g':
        return googleSearch(query);

      case 'mix':
        return 'https://mixpanel.com/project/2896091/view/3425367/app/events';

      case 'p':
      case 'o':
        return `https://www.integratingreflexes.com/wp-admin/post.php?post=${query}&action=edit`;

      case 'hl':
        return `https://app.champagne-room.io/v2/location/fPDoZjFPs8oBCPf3hI3h/contacts/detail/${query}`;

      case 'u':
        if (/^\d+$/.test(query)) {
          return `https://www.integratingreflexes.com/wp-admin/user-edit.php?user_id=${query}`;
        } else {
          return `https://www.integratingreflexes.com/wp-admin/users.php?s=${encodeURIComponent(query)}`;
        }

      case 'ur':
        if (/^\d+$/.test(query)) {
          return `https://www.integratingreflexes.com/wp-admin/users.php?user_id=${query}&page=ritp-profile-edit`;
        } else if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(query)) {
          return `https://www.integratingreflexes.com/wp-admin/users.php?s=${encodeURIComponent(query)}`;
        } else {
          return googleSearch(searchQuery);
        }
    }
  },

  thebehavioral() {
    switch (command) {
      case 'u':
        return `https://thebehavioral.tech/admin/users?search=${query}`;
    }
  },
};

const DEFAULT_MODE = 'ritp';

// Command parser function
function parseCommand(searchQuery, mode) {
  // Default to Google if no command is specified
  if (!searchQuery) {
    return 'https://www.google.com/';
  }

  // Split the query into command and the rest
  const parts = searchQuery.trim().split(' ');
  const command = parts[0].toLowerCase();
  const query = parts.slice(1).join(' ');

  const handler = handlers[mode] || handlers[DEFAULT_MODE];

  // If no specific command pattern is matched, default to Google search
  return handler(command, query, searchQuery) || googleSearch(searchQuery);
}

// Main route for handling search requests
app.get('/bunnylol', (req, res) => {
  const searchQuery = req.query.search || '';
  const mode = req.query.mode || DEFAULT_MODE;
  const redirectUrl = parseCommand(searchQuery, mode);
  res.redirect(redirectUrl);
});

// Start the server
app.listen(PORT, () => {
  console.log(`BunnyLOL running at http://localhost:${PORT}`);
  console.log(`Use http://localhost:${PORT}/bunnylol?search=%s as your search engine URL`);
});
