use nashville_housing;

SELECT 
    *
FROM
    nashville_housing;
    
    
SELECT 
    *
FROM
    nashville_housing
WHERE
    PropertyAddress IS NULL;
    
    
SELECT 
    *
FROM
    nashville_housing
ORDER BY ParcelID;    
    
# ParcelID has some repeated ids ones that have PropertyAddress available
# we'll use those available ones to populate the nulls


SELECT 
    n1.ParcelID,
    n1.PropertyAddress,
    n2.ParcelID,
    n2.PropertyAddress
FROM
    nashville_housing n1
        JOIN
    nashville_housing n2 ON n1.ParcelID = n2.ParcelID
        AND n1.UniqueID <> n2.UniqueID
WHERE
    n1.PropertyAddress IS NULL;
 
 
UPDATE nashville_housing AS n1
        JOIN
    nashville_housing AS n2 ON n1.ParcelID = n2.ParcelID
        AND n1.UniqueID <> n2.UniqueID 
SET 
    n1.PropertyAddress = COALESCE(n1.PropertyAddress, n2.PropertyAddress)
WHERE
    n1.PropertyAddress IS NULL;


SELECT 
    SUBSTRING(PropertyAddress,
        1,
        LOCATE(',', PropertyAddress) - 1) AS address,
    SUBSTRING(PropertyAddress,
        LOCATE(',', PropertyAddress) + 1,
        LENGTH(PropertyAddress)) AS city
FROM
    nashville_housing;


ALTER TABLE nashville_housing
ADD COLUMN PropertySplitAddress VARCHAR(255) AFTER PropertyAddress;

ALTER TABLE nashville_housing
ADD COLUMN PropertySplitCity VARCHAR(255) AFTER PropertySplitAddress;


UPDATE nashville_housing 
SET 
    PropertySplitAddress = SUBSTRING(PropertyAddress,
        1,
        LOCATE(',', PropertyAddress) - 1);
        
UPDATE nashville_housing 
SET 
    PropertySplitCity = SUBSTRING(PropertyAddress,
        LOCATE(',', PropertyAddress) + 1,
        LENGTH(PropertyAddress));
        
        
SELECT 
    *
FROM
    nashville_housing;  
    
    
SELECT 
    SUBSTRING_INDEX(OwnerAddress, ',', 1) AS adress,
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),
            ',',
            - 1) AS city,
    SUBSTRING_INDEX(OwnerAddress, ',', - 1) AS state
FROM
    nashville_housing;
    
ALTER TABLE nashville_housing
ADD COLUMN OwnerSplitAdress VARCHAR(255) AFTER OwnerAddress;

ALTER TABLE nashville_housing 
ADD COLUMN OwnerSplitCity VARCHAR(255) AFTER OwnerSplitAdress;

ALTER TABLE nashville_housing
ADD COLUMN OwnerSplitState VARCHAR(255) AFTER OwnerSplitCity;


UPDATE nashville_housing 
SET 
    OwnerSplitAdress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

UPDATE nashville_housing 
SET 
    OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),
            ',',
            - 1);
            
UPDATE nashville_housing 
SET 
    OwnerSplitState = SUBSTRING_INDEX(OwnerAddress, ',', - 1);     
    
    
SELECT 
    *
FROM
    nashville_housing;
    
    
    
SELECT DISTINCT
    (SoldAsVacant), COUNT(SoldAsVacant)
FROM
    nashville_housing
GROUP BY SoldAsVacant
ORDER BY COUNT(SoldAsVacant);    


SELECT 
    SoldAsVacant,
    CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END AS replacement
FROM
    nashville_housing;    
    
    
UPDATE nashville_housing 
SET 
    SoldAsVacant = CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;   
    
SELECT *, 
	   ROW_NUMBER() OVER (PARTITION BY  ParcelID, 
										   PropertyADdress, 
                                           SaleDate, 
                                           SalePrice, 
                                           LegalReference
                                           ORDER BY UniqueID) AS row_num   
FROM nashville_housing;                                           
    
# removing duplicates
# considering rows are duplicates if they have the same ParcelID, PropertyAdress, SaleDate, SalePrice, and LegalReference 

WITH row_numb AS (
SELECT *, 
	   ROW_NUMBER() OVER (PARTITION BY  ParcelID, 
										   PropertyADdress, 
                                           SaleDate, 
                                           SalePrice, 
                                           LegalReference
                                           ORDER BY UniqueID) AS row_num   
FROM nashville_housing
)
DELETE FROM nashville_housing
WHERE (ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference, UniqueID) IN (
    SELECT ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference, UniqueID
    FROM row_numb
    WHERE row_num > 1
);

COMMIT;


ALTER TABLE nashville_housing
DROP COLUMN PropertyAddress;

ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress;

ALTER TABLE nashville_housing
DROP COLUMN TaxDistrict;

SELECT 
    *
FROM
    nashville_housing;



    