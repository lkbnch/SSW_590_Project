# Crypto Compass

A real-time cryptocurrency tracking application with interactive charts and operational metrics.

## Quick Start Guide

### Prerequisites
- Python 3 (for local server)
- Modern web browser (Chrome, Firefox, Safari, or Edge)

### Running the Application

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/crypto-compass.git
   cd crypto-compass
   ```

2. **Start the local server**
   You have two options:

   Option 1 - Using npm:
   ```bash
   npm start
   ```

   Option 2 - Using Python directly:
   ```bash
   python3 -m http.server 8000
   ```

3. **Access the application**
   Open your web browser and go to:
   ```
   http://localhost:8000
   ```

4. **Login credentials**
   Use one of these test accounts:
   - Username: `admin`, Password: `admin123`
   - Username: `user1`, Password: `password1`
   - Username: `user2`, Password: `password2`

## Features

- Real-time cryptocurrency price tracking
- Interactive price charts
- Operational metrics dashboard
- SWOT analysis of tools
- Secure login system

## Project Structure

```
crypto-compass/
├── index.html          # Login page
├── coinsMain.html      # Main dashboard
├── swot.html           # SWOT analysis page
├── learningSpace.html  # Educational resources
├── style.css          # Main styles
├── login.js           # Login functionality
├── images/            # Image assets
└── package.json       # Project configuration
```

## Development

### Local Development
1. Start the development server:
   ```bash
   npm start
   ```
2. Open `http://localhost:8000` in your browser
3. Make changes to the files
4. Refresh the browser to see changes

### Testing
- The application uses the CoinGecko API for real-time data
- Test the chart functionality by clicking on different cryptocurrencies
- Check the operational metrics dashboard
- Verify the SWOT analysis page

## Troubleshooting

### Common Issues

1. **Server won't start**
   - Make sure Python 3 is installed
   - Check if port 8000 is available
   - Try a different port: `python3 -m http.server 8080`

2. **Charts not updating**
   - Check browser console for errors
   - Verify internet connection
   - Ensure CoinGecko API is accessible

3. **Login issues**
   - Clear browser cache
   - Try different test credentials
   - Check browser console for errors

### Getting Help
- Check the browser console for error messages
- Verify all files are in the correct directory
- Ensure you're using the correct URL (http://localhost:8000)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
