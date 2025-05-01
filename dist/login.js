// Pre-defined users (in a real app, this would be in a database)
const users = [
    { username: 'admin', password: 'admin123', role: 'admin' },
    { username: 'user1', password: 'password1', role: 'user' },
    { username: 'user2', password: 'password2', role: 'user' }
];

document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorMessage = document.getElementById('error-message');
    
    // Find user in our "database"
    const user = users.find(u => u.username === username && u.password === password);
    
    if (user) {
        // Store user info in session storage
        sessionStorage.setItem('currentUser', JSON.stringify({
            username: user.username,
            role: user.role
        }));
        
        // Redirect to main page
        window.location.href = 'coinsMain.html';
    } else {
        errorMessage.textContent = 'Invalid username or password';
        errorMessage.style.display = 'block';
    }
}); 