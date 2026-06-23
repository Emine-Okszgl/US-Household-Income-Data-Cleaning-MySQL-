-- US Household Income Data Cleaning Project
-- Tool: MySQL
-- Objective: Clean and prepare the dataset for exploratory data analysis.

-- 1. View imported data
SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;


-- 2. Rename incorrect column name caused by CSV encoding issue
ALTER TABLE us_project.us_household_income_statistics 
RENAME COLUMN ï»¿id TO id;


-- 3. Count total records
SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;


-- 4. Check duplicate records in us_household_income
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;


-- 5. Find duplicate rows using ROW_NUMBER()
SELECT * 
FROM (
    SELECT 
        row_id, 
        id,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
    FROM us_project.us_household_income
) duplicates
WHERE row_num > 1;


-- 6. Remove duplicate rows
DELETE FROM us_project.us_household_income
WHERE row_id IN (
    SELECT row_id 
    FROM (
        SELECT 
            row_id, 
            id,
            ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
        FROM us_project.us_household_income
    ) duplicates
    WHERE row_num > 1
);


-- 7. Check duplicate records in us_household_income_statistics
SELECT id, COUNT(id)
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;


-- 8. Check inconsistent state names
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY State_Name;


-- 9. Fix misspelled state name
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';


-- 10. Find empty Place values
SELECT *
FROM us_project.us_household_income
WHERE Place = ''
ORDER BY id;


-- 11. Investigate records from Autauga County
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY County;


-- 12. Fix incorrect place name
UPDATE us_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
  AND City = 'Vinemont';


-- 13. Count records by Type
SELECT Type, COUNT(*) AS type_count
FROM us_project.us_household_income
GROUP BY Type
ORDER BY type_count DESC;


-- 14. Fix incorrect Type name
UPDATE us_project.us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';


-- 15. Verify Type values after cleaning
SELECT Type, COUNT(*) AS type_count
FROM us_project.us_household_income
GROUP BY Type
ORDER BY type_count DESC;


-- 16. Check ALand and AWater values
SELECT ALand, AWater
FROM us_project.us_household_income
WHERE AWater = 0 
   OR AWater = ''
   OR AWater IS NULL;