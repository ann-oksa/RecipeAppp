# RecipeAppp

### Summary: 
This app fetches and displays recipes from an API. It includes three buttons to switch between different data sources (All Recipes, Malformed Data, Empty Data). Recipes are shown with their name, photo, and cuisine type, and images are cached to reduce network usage

### Focus Areas: 
- Image Caching: Images are cached in memory and on disk to avoid redundant requests.
- Error Handling: The app gracefully handles malformed and empty data.
- Swift Concurrency: Utilized async/await for all asynchronous operations to ensure smooth UI updates.

### Time Spent: 14 hours

### Weakest Part of the Project: 
- The UI design is basic and can be improved
- Error handling in the UI is functional but could be more polished with retry options

### Additional Information: Branches
- main: Empty
- develop: Basic implementation with one URL request (no tests)
- develop-three-buttons: Includes 3 buttons for different requests and unit tests
