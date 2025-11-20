# Code Analysis and Issues

## 1. Home Page Image Layout Issue
**Problem:** In the home page (index.html), the images should be displayed horizontally, not in a large grid.

**Analysis:**
- The issue is in the CSS grid layout defined in `static/css/styles.css`
- The current grid is set to 2 columns with `grid-template-columns: repeat(2, minmax(0, 1fr))`
- The grid container has a class `grid-4-col` but only implements 2 columns
- For a horizontal layout, we should modify the grid to display items in a single row with horizontal scrolling

**Files to Modify:**
- `static/css/styles.css` - Update the grid layout
- `templates/index.html` - May need container adjustments

**AI Prompt:**
```
Update the CSS in styles.css to display recipe cards in a horizontal scrollable row instead of a grid. The cards should:
1. Be in a single row with horizontal scrolling
2. Have consistent width and height
3. Maintain proper spacing between cards
4. Be responsive on mobile devices
5. Show partial next card to indicate scrollability

Current CSS:
.grid-4-col {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 20px;
    padding: 0 20px;
}
```

## 2. Missing Images for Curry and Adobo
**Problem:** The image references for 'curry' and 'adobo' don't work, displaying a broken image icon.

**Analysis:**
- The issue is in the database records for these recipes
- In `app.py`, if no image is found, it falls back to 'images/about.webp'
- The problem could be:
  1. The image files are missing from the static/images directory
  2. The `image_path` in the database is incorrect
  3. The files have incorrect permissions

**Files to Check:**
- Database records for 'curry' and 'adobo' recipes
- `static/images/` directory for the actual image files
- `app.py` - image handling logic

**AI Prompt:**
```
Help fix the broken image references for 'curry' and 'adobo' recipes. The solution should:
1. Check the database for the current image_path values
2. Verify if the image files exist in the static/images directory
3. If files are missing, suggest appropriate filenames based on recipe names
4. Provide SQL to update the database with correct paths
5. Ensure proper file permissions (644 for files, 755 for directories)

Example SQL to check current data:
SELECT id, name, image_path FROM recipes WHERE name LIKE '%curry%' OR name LIKE '%adobo%';
```

## 3. Missing Difficulty Column
**Problem:** The difficulty column doesn't appear in the recipe listings.

**Analysis:**
- In `app.py`, the index route doesn't select the difficulty column from the database
- The SQL query only selects: `id, name, category, short_description, image_path`
- The template `index.html` doesn't display difficulty even if it was available
- The database schema includes a difficulty column (as seen in the recipe_detail route)

**Files to Modify:**
- `app.py` - Update the SQL query to include difficulty
- `templates/index.html` - Add display for difficulty
- May need to update the card styling in `static/css/styles.css`

**AI Prompt:**
```
Add difficulty display to the recipe cards in index.html. The solution should:
1. Update the SQL query in app.py to include the difficulty column
2. Modify the recipe card template to show difficulty with appropriate styling
3. Add CSS styles for difficulty indicators (e.g., color-coded or with icons)
4. Ensure responsive design works well with the new element
5. Handle cases where difficulty might be null

Current template code in index.html:
<div class="card">
    <img src="{{ recipe.image_path }}" alt="{{ recipe.name }}" class="card-img-top">
    <div class="card-body">
        <h5 class="card-title">{{ recipe.name }}</h5>
        <p class="card-text">{{ recipe.short_description }}</p>
    </div>
</div>
```

## 4. Bullet Point Formatting in Recipe Detail
**Problem:** In recipe_detail.html, the bullet points do not format correctly.

**Analysis:**
- The issue is in the styling of list items in `recipe_detail.html`
- The template correctly uses `<ul>` and `<ol>` for ingredients and directions
- The problem is likely in the CSS where list styles might be overridden or not properly set
- The current CSS might be missing proper list styling for the recipe details section

**Files to Modify:**
- `static/css/styles.css` - Add or update list styling for `.ingredients-section` and `.directions-section`
- `templates/recipe_detail.html` - May need additional classes or structure

**AI Prompt:**
```
Improve the bullet point formatting in recipe_detail.html. The solution should:
1. Style unordered lists for ingredients with custom bullet points (e.g., food icons or colored circles)
2. Style ordered lists for directions with clear, readable numbers
3. Add proper spacing between list items
4. Ensure good contrast and readability
5. Make lists responsive on mobile devices

Current HTML structure:
<section class="ingredients-section">
    <h2>Ingredients</h2>
    <ul>
        {% for item in recipe.ingredients %}
        <li>{{ item }}</li>
        {% endfor %}
    </ul>
</section>

<section class="directions-section">
    <h2>Directions</h2>
    <ol>
        {% for step in recipe.directions %}
        <li>{{ step }}</li>
        {% endfor %}
    </ol>
</section>
```

## 5. Mobile Layout Adjustment
**Problem:** The recipe cards should switch from horizontal scroll to vertical stack layout on mobile devices for better usability.

**Analysis:**
- Currently, the cards use horizontal scrolling on all screen sizes
- Mobile users typically prefer vertical scrolling for better one-handed use
- The breakpoint for mobile is set at 768px in the existing media queries

**Solution Implemented:**
1. Modified the mobile media query to change the layout:
   - Set cards to stack vertically on mobile
   - Adjusted card width to be full width on small screens
   - Maintained horizontal scroll behavior on larger screens

2. Key CSS changes:
   ```css
   @media (max-width: 768px) {
       .grid-4-col {
           display: flex;
           flex-direction: column;
           gap: 16px;
           padding: 0 16px;
       }
       
       .card {
           width: 100%;
           margin-bottom: 16px;
       }
   }
   ```

**Verification Steps:**
1. Open the page on a mobile device or use browser dev tools
2. Verify cards stack vertically when viewport width is ≤ 768px
3. Ensure horizontal scroll returns on larger screens
4. Check that all content remains accessible and readable

## Additional Notes
- The application uses SQLite for the database
- Image uploads are handled and stored in `static/images/uploads/`
- The application has proper error handling for missing images (falls back to about.webp)
- The codebase follows a clean structure with separate routes, templates, and static files