create database nashville_housing;
use nashville_housing;

CREATE TABLE nashville_housing (
	UniqueID  INTEGER,
	ParcelID TEXT NULL,
	LandUse TEXT NULL,
	PropertyAddress TEXT NULL,
	SaleDate DATE NULL,
	SalePrice INTEGER NULL,
	LegalReference TEXT NULL,
	SoldAsVacant TEXT NULL,
	OwnerName TEXT NULL,
	OwnerAddress TEXT NULL,
	Acreage FLOAT NULL,
	TaxDistrict TEXT NULL,
	LandValue INTEGER NULL,
	BuildingValue INTEGER NULL,
	TotalValue INTEGER NULL,
	YearBuilt INTEGER NULL,
	Bedrooms TINYINT NULL,
	FullBath TINYINT NULL,
	HalfBath TINYINT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nashville_housing.csv' INTO TABLE nashville_housing
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT 
    *
FROM
    nashville_housing
LIMIT 20;

COMMIT;


