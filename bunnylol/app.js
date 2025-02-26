const express = require('express');
const app = express();
const PORT = 8998;

// Middleware to parse query parameters
app.use(express.urlencoded({ extended: true }));

// Command parser function
function parseCommand(searchQuery) {
  // Default to Google search if no command is specified
  if (!searchQuery) {
    return 'https://www.google.com/';
  }

  // Split the query into command and the rest
  const parts = searchQuery.trim().split(' ');
  const command = parts[0].toLowerCase();
  const query = parts.slice(1).join(' ');

  // Command handlers
  switch (command) {
    case 'g':
      return `https://www.google.com/search?q=${encodeURIComponent(query)}`;

    case 'mix':
      return 'https://mixpanel.com/project/2896091/view/3425367/app/events';
   
    case 'p':
    case 'o':
      return `https://www.integratingreflexes.com/wp-admin/post.php?post=${query}&action=edit`;

    case 'u':
      if (/^\d+$/.test(query)) {
        return `https://www.integratingreflexes.com/wp-admin/user-edit.php?user_id=${query}`;
      } else if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(query)) {
        return `https://www.integratingreflexes.com/wp-admin/users.php?s=${encodeURIComponent(query)}`;
      } else {
        return `https://www.google.com/search?q=${encodeURIComponent(searchQuery)}`;
      }

    case 'ur':
      if (/^\d+$/.test(query)) {
        return `https://www.integratingreflexes.com/wp-admin/users.php?user_id=${query}&page=ritp-profile-edit`;
      } else {
        return `https://www.google.com/search?q=${encodeURIComponent(searchQuery)}`;
      }
    
    // If no specific command pattern is matched, default to Google search
    default:
      return `https://www.google.com/search?q=${encodeURIComponent(searchQuery)}`;
  }
}

// Main route for handling search requests
app.get('/bunnylol', (req, res) => {
  const searchQuery = req.query.search || '';
  const redirectUrl = parseCommand(searchQuery);
  res.redirect(redirectUrl);
});

// Start the server
app.listen(PORT, () => {
  console.log(`BunnyLOL running at http://localhost:${PORT}`);
  console.log(`Use http://localhost:${PORT}/bunnylol?search=%s as your search engine URL`);
});
