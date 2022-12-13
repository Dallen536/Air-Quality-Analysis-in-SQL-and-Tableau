DROP SCHEMA IF EXISTS `_team15aqi` ;
CREATE SCHEMA IF NOT EXISTS `_team15aqi` DEFAULT CHARACTER SET utf8mb3;
USE `_team15aqi` ;

DROP TABLE IF EXISTS `GDP_data` ;

CREATE TABLE IF NOT EXISTS `GDP_data`(
 `stateCodes` VARCHAR(2),
  `GDP2010` dec(10,2),
  `GDP2011` dec(10,2),
  `GDP2012` dec(10,2),
  `GDP2013` dec(10,2),
  `GDP2014` dec(10,2),
CONSTRAINT FK_StateCodes_GDP FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));
  
DROP TABLE IF EXISTS `Census_data` ;

CREATE TABLE IF NOT EXISTS `Census_data`(
 `stateCodes` VARCHAR(2),
  `census2010pop` INT,
  `popestimate2010` INT,
  `popestimate2011` INT,
  `popestimate2012` INT,
  `popestimate2013` INT,
  `popestimate2014` INT,
  `rbirth2011` dec(10,2),
  `rbirth2012` dec(10,2),
  `rbirth2013` dec(10,2),
  `rbirth2014` dec(10,2),
  `rdeath2011` dec(10,2),
  `rdeath2012` dec(10,2),
  `rdeath2013` dec(10,2),
  `rdeath2014` dec(10,2),
CONSTRAINT FK_StateCodes_CD FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));
  
DROP TABLE IF EXISTS `AQI_locations` ;

CREATE TABLE IF NOT EXISTS `AQI_locations`(
 `locationID` VARCHAR(4),
 `stateCodes` VARCHAR(2),
  `state` VARCHAR(20),
  `country` VARCHAR(20),
  `latitude` dec(10,5),
  `longitude` dec(10,5),
CONSTRAINT FK_StateCodes_AQI FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));
  
DROP TABLE IF EXISTS `Categories` ;

CREATE TABLE IF NOT EXISTS `Categories`(
 `locationID` VARCHAR(4),
 `year` DATE,
 `DaysWithAQI` INT,
 `GoodDays` INT,
 `ModerateDays` INT,
 `UnhealthyForSensitiveGroupDays` INT,
 `UnhealthyDays` INT,
 `VeryUnhealthyDays` INT,
 `HazardousDays` INT,
  PRIMARY KEY (`locationID`, `year`));

USE _team15aqi;

DROP TABLE IF EXISTS `Measurements` ;

CREATE TABLE IF NOT EXISTS `Measurements`(
 `locationID` VARCHAR(4),
 `year` DATE,
 `MaxAQI` INT,
 `90percentileAQI` INT,
 `MedianAQI` INT,
 `DaysCO` INT,
 `DaysNO2` INT,
 `DaysOzone` INT,
 `DaysSO2` INT,
 `DaysPM2.5` INT,
 `DaysPM10` INT,
  PRIMARY KEY (`locationID`));
  
DROP TABLE IF EXISTS `state_data` ;

CREATE TABLE IF NOT EXISTS `state_data`(
 `stateCodes` VARCHAR(2),
  `state` VARCHAR(50),
  `region` INT,
  `division` INT,
  `coast` INT,
  `greatlakes` INT,
  PRIMARY KEY (`stateCodes`));
  
  
DROP TABLE IF EXISTS `consumption_data` ;

CREATE TABLE IF NOT EXISTS `consumption_data`(
 `stateCodes` VARCHAR(2),
  `CoalC2010` INT,
  `CoalC2011` INT,
  `CoalC2012` INT,
  `CoalC2013` INT,
  `CoalC2014` INT,
  `HydroC2010` INT,
  `HydroC2011` INT,
  `HydroC2012` INT,
  `HydroC2013` INT,
  `HydroC2014` INT,
  `NatGasC2010` INT,
  `NatGasC2011` INT,
  `NatGasC2012` INT,
  `NatGasC2013` INT,
  `NatGasC2014` INT,
 `LPGC2010` INT,
 `LPGC2011` INT,
 `LPGC2012` INT,
 `LPGC2013` INT,
 `LPGC2014` INT,
CONSTRAINT FK_StateCodes_Con FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));



DROP TABLE IF EXISTS `production_data` ;

CREATE TABLE IF NOT EXISTS `production_data`(
 `stateCodes` VARCHAR(2),
  `CoalP2010` INT,
  `CoalP2011` INT,
  `CoalP2012` INT,
  `CoalP2013` INT,
  `CoalP2014` INT,
  `HydroP2010` INT,
  `HydroP2011` INT,
  `HydroP2012` INT,
  `HydroP2013` INT,
  `HydroP2014` INT,
CONSTRAINT FK_StateCodes_PD FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));


DROP TABLE IF EXISTS Price_Data;
CREATE TABLE Price_Data(
	StateCodes	VARCHAR(2) NOT NULL,	
	CoalPrice2010	DECIMAL (5,2) NULL,	
	CoalPrice2011	DECIMAL (5,2) NULL,	
	CoalPrice2012	DECIMAL (5,2) NULL,	
	CoalPrice2013	DECIMAL (5,2) NULL,	
	CoalPrice2014	DECIMAL (5,2) NULL,	
	NatGasPrice2010	DECIMAL (5,2) NULL,	
	NatGasPrice2011	DECIMAL (5,2) NULL,	
	NatGasPrice2012	DECIMAL (5,2) NULL,	
	NatGasPrice2013	DECIMAL (5,2) NULL,	
	NatGasPrice2014	DECIMAL (5,2) NULL,	
	LPGPrice2010	DECIMAL (5,2) NULL,	
	LPGPrice2011	DECIMAL (5,2) NULL,	
	LPGPrice2012	DECIMAL (5,2) NULL,	
	LPGPrice2013	DECIMAL (5,2) NULL,	
	LPGPrice2014	DECIMAL (5,2) NULL,	
CONSTRAINT FK_StateCodes_PriceD FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));

  
DROP TABLE IF EXISTS Expenditure_Data;
CREATE TABLE Expenditure_Data(
	StateCodes	VARCHAR(2) NOT NULL,
	CoalE2010	DECIMAL (8,2) NULL,
	CoalE2011	DECIMAL (8,2) NULL,
	CoalE2012	DECIMAL (8,2) NULL,
	CoalE2013	DECIMAL (8,2) NULL,
	CoalE2014	DECIMAL (8,2) NULL,
	NatGasE2010	DECIMAL (8,2) NULL,
	NatGasE2011	DECIMAL (8,2) NULL,
	NatGasE2012	DECIMAL (8,2) NULL,
	NatGasE2013	DECIMAL (8,2) NULL,
	NatGasE2014	DECIMAL (8,2) NULL,
	LPGE2010	DECIMAL (8,2) NULL,
	LPGE2011	DECIMAL (8,2) NULL,
	LPGE2012	DECIMAL (8,2) NULL,
	LPGE2013	DECIMAL (8,2) NULL,
	LPGE2014	DECIMAL (8,2) NULL,
CONSTRAINT FK_StateCodes_ED FOREIGN KEY (StateCodes) REFERENCES State_Data (StateCodes));

SELECT * from Expenditure_data;

#INDEXES

CREATE INDEX STATE_CODE ON STATE_DATA(STATECODES);

CREATE INDEX LOCATION_ID ON AQI_LOCATIONS(LOCATIONID);

CREATE INDEX YEARS ON CATEGORIES(YEAR);