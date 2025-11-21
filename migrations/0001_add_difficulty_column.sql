-- Add difficulty column to recipes table
ALTER TABLE recipes ADD COLUMN difficulty TEXT;

-- Set default difficulty for existing recipes
UPDATE recipes SET difficulty = 'Medium' WHERE difficulty IS NULL;
