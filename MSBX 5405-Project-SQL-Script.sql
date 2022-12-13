/* Bella Franz */ 
#How many states had a max AQI more than 150 for each year between 2010-2014? 
USE _team15aqi;

SELECT distinct(count(a.county)) AS 'No of states', m.year
FROM aqi_locations as a
JOIN measurements as m
ON a.locationID = m.locationID
WHERE m.maxaqi > 150
GROUP BY m.year desc
ORDER BY count(a.county);

#How many states had a max AQI less than 150 for each year between 2010-2014? 
SELECT distinct(count(a.locationID)) AS 'No of states', m.year
FROM aqi_locations as a
JOIN measurements as m
ON a.locationID = m.locationID
WHERE m.maxaqi < 150
GROUP BY m.year desc
ORDER BY count(a.locationID);

# Which states had a ‘hazardous’ AQI for each year between 2010 and 2014
SELECT distinct(a.state) as 'States', c.HazardousDays, c.year
FROM aqi_locations as a
JOIN categories as c 
ON a.locationID = c.locationID
ORDER BY c.year;

#Compare the death rate (rdeath) to the max AQI and most number of ‘hazardous’ AQI for the years 2010-2014 by state.
SELECT c.rdeath2011, c.rdeath2012, c.rdeath2013, c.rdeath2014, 
max(m.MaxAQI) as 'Max AQI', 
max(cat.HazardousDays) as 'Most hazardous days',
a.state
FROM census_data as c
JOIN aqi_locations as a
ON c.stateCodes = a.stateCode
JOIN measurements as m
ON a.locationID = m.locationID
JOIN categories as cat
ON m.locationID = cat.locationID
GROUP BY a.state
ORDER BY max(MaxAQI);

# Which states were the most energy efficient between 2010 and 2014? Look at the production and consumption tables and show max/ min for each state for coal, hydro, natgas, and LPG.
SELECT s.state,
min(c.CoalC2010), min(c.CoalC2011), min(c.CoalC2012), min(c.CoalC2013), min(c.CoalC2014),
min(c.HydroC2010), min(c.HydroC2011), min(c.HydroC2012), min(c.HydroC2013), min(c.HydroC2014),	
min(c.NatGasC2010), min(c.NatGasC2011), min(c.NatGasC2012), min(c.NatGasC2013), min(c.NatGasC2014),	
min(c.LPGC2010), min(c.LPGC2011), min(c.LPGC2012), min(c.LPGC2013), min(c.LPGC2014),
max(p.CoalP2010), max(p.CoalP2011), max(p.CoalP2012), max(p.CoalP2013), max(p.CoalP2014),	
max(p.HydroP2010), max(p.HydroP2011), max(p.HydroP2012), max(p.HydroP2013), max(p.HydroP2014)
FROM consumption_data as c 
JOIN production_data as p
ON c.StateCodes = p.stateCodes
JOIN state_data as s
ON p.stateCodes = s.stateCode
GROUP BY s.state
ORDER BY min(c.CoalC2010), min(c.CoalC2011), min(c.CoalC2012), min(c.CoalC2013), min(c.CoalC2014),
min(c.HydroC2010), min(c.HydroC2011), min(c.HydroC2012), min(c.HydroC2013), min(c.HydroC2014),	
min(c.NatGasC2010), min(c.NatGasC2011), min(c.NatGasC2012), min(c.NatGasC2013), min(c.NatGasC2014),	
min(c.LPGC2010), min(c.LPGC2011), min(c.LPGC2012), min(c.LPGC2013), min(c.LPGC2014);



/* Danielle Allen*/ 
SELECT state, CoalPrice2012
FROM state_data
JOIN price_data
ON state_data.StateCode = price_data.StateCodes
GROUP BY state
ORDER BY CoalPrice2012 DESC;

SELECT state, CoalC2011, CoalC2012, CoalC2013, CoalC2014, rbirth2011,rbirth2012,rbirth2013,rbirth2014
FROM state_data
JOIN consumption_data
ON state_data.StateCode = consumption_data.StateCodes
JOIN census_data
USING (StateCodes)
GROUP BY state
ORDER BY state;

SELECT state, CoalPrice2014, GDP2014
FROM state_data
JOIN price_data
ON state_data.StateCode = price_data.StateCodes
JOIN gdp_data
USING(stateCodes)
WHERE GDP2014 = (
SELECT MAX(GDP2014)
FROM gdp_data)
GROUP BY state;

SELECT state, GDP2011, GDP2012, GDP2013, GDP2014, rbirth2011, rbirth2012, rbirth2013, rbirth2014
FROM state_data
JOIN gdp_data
ON state_data.StateCode = gdp_data.StateCodes
JOIN census_data
USING (StateCodes)
GROUP BY state
ORDER BY state;

SELECT state, year, COUNT(GoodDays)
FROM aqi_locations
JOIN categories
USING (locationID)
GROUP BY year, state
ORDER BY COUNT(GoodDays) DESC;



/* Morgan Likens*/ 
USE _TEAM15AQI;

#1. 
SELECT STATECODES, NATGASC2013, NATGASPRICE2013, AVG(NATGASPRICE2013)
	OVER(
		) AS 'AVG 2013 NAT GAS PRICE'
FROM CONSUMPTION_DATA 
JOIN PRICE_DATA 
USING(STATECODES)
ORDER BY NATGASC2013 DESC
LIMIT 5;

#2. 
SELECT STATECODES, SUM(DAYSSO2) AS '2011 DAYS SO2', COALP2011
FROM PRODUCTION_DATA P
JOIN AQI_LOCATIONS A
ON P.STATECODES = A.STATECODE
JOIN MEASUREMENTS
USING(LOCATIONID)
WHERE YEAR = 2011
GROUP BY STATECODES
ORDER BY COALP2011 DESC;

#3. 
SELECT YEAR, SUM(MAXAQI) AS 'YEARLY AQI'
FROM PRODUCTION_DATA P
JOIN AQI_LOCATIONS A
ON P.STATECODES = A.STATECODE
JOIN MEASUREMENTS
USING(LOCATIONID)
GROUP BY YEAR
ORDER BY SUM(MAXAQI) DESC;

#4. 
SELECT DIVISION, COALP2012, HYDROP2012
FROM STATE_DATA S
JOIN PRODUCTION_DATA P
ON S.STATECODE = P.STATECODES
GROUP BY DIVISION;

#5. 
SELECT REGION, MAX(COALPRICE2014), MAX(NATGASPRICE2014), MAX(LPGPRICE2014)
FROM PRICE_DATA P
JOIN STATE_DATA S
ON P.STATECODES = S.STATECODE
GROUP BY REGION;



/* Rachel Raifsnider */ 
USE _team15aqi;

#1 Which states produce hydro and coal?
SELECT StateCodes
FROM production_data
WHERE (CoalP2010 + CoalP2011 + CoalP2012 + CoalP2013 + CoalP2014 ) > 0 AND
(HydroP2010 + HydroP2011 + HydroP2012 + HydroP2013 + HydroP2014) > 0;

#2 Which states produce only hydropower?
SELECT StateCodes, (CoalP2010 + CoalP2011  + CoalP2012 + CoalP2013 + CoalP2014 ) AS 'TotalCoalP',
HydroP2010, HydroP2011, HydroP2012, HydroP2013, HydroP2014 
FROM production_data
WHERE (CoalP2010 + CoalP2011  + CoalP2012 + CoalP2013 + CoalP2014 ) = 0 AND
(HydroP2010 + HydroP2011 + HydroP2012 + HydroP2013 + HydroP2014) > 0;

#3 Which state has the most amount of unhealthy days overall? 
SELECT stateCode, SUM(UnhealthyDays) AS TotUnhealthy4yrs
FROM categories
JOIN aqi_locations
USING(locationID)
GROUP BY stateCode
ORDER BY SUM(UnhealthyDays) DESC;

#4 Which states produced more coal than they consumed in 2014?
SELECT StateCodes, CoalP2014, CoalC2014, CoalP2014 - CoalC2014 AS DiffCoalPandC
FROM consumption_data
JOIN production_data
USING(StateCodes)
WHERE CoalP2014  > CoalC2014 
GROUP BY StateCodes;

#5 Which states produce more than the average amount of coal production and hydro production?
SELECT StateCodes, CoalP2010, (SELECT ROUND(AVG(CoalP2010),2) FROM production_data) AS avgCP2010,
HydroP2010,(SELECT ROUND(AVG(HydroP2010),2) FROM production_data) AS avgHP2010
FROM production_data
WHERE (CoalP2010) > (SELECT AVG(CoalP2010) FROM production_data) AND
(HydroP2010) > (SELECT AVG(HydroP2010) FROM production_data);



/* Samantha Fildish*/ 
#1 Do states with a higher average population have a worse average AQI rating over the years 2010-2014? 
		SELECT DISTINCT stateCodes,ROUND(AVG(popestimate2014+popestimate2010+popestimate2011+popestimate2012+popestimate2013),0) AS "Avg Population",
			ROUND(AVG(m.MedianAQI),2) AS "Avg AQI",
			CASE WHEN ROUND(AVG(m.MedianAQI),2) BETWEEN 0 AND 50 THEN 'Good'
				 WHEN ROUND(AVG(m.MedianAQI),2) BETWEEN 51 AND 100 THEN 'Moderate'
				 WHEN ROUND(AVG(m.MedianAQI),2) BETWEEN 101 AND 150 THEN 'Unhealthy for Sensitive Groups'
				 WHEN ROUND(AVG(m.MedianAQI),2) BETWEEN 151 AND 200 THEN 'Unhealthy'
				 WHEN ROUND(AVG(m.MedianAQI),2) BETWEEN 201 AND 300 THEN 'Very Unhealthy'
				 WHEN ROUND(AVG(m.MedianAQI),2) > 300 THEN 'Hazardous' ELSE NULL END AS "AVG Status"
		FROM census_data as cd
		JOIN aqi_locations as aq
			on cd.stateCodes = aq.stateCode
		JOIN measurements as m
			on aq.locationID = m.locationID
		group by stateCodes
		order by ROUND(AVG(m.MedianAQI),2) DESC;
        
#2 How does poor AQI relate to Death Rates over the years?
        SELECT DISTINCT stateCodes,ROUND(AVG(rdeath2011+rdeath2012+rdeath2013+rdeath2014)) AS "Avg Death Rate",
			ROUND(AVG(UnhealthyDays),2) AS "Avg Unhealthy Days"
		FROM census_data as cd	JOIN aqi_locations as aq
			on cd.stateCodes = aq.stateCode
		JOIN categories as c
			on aq.locationID = c.locationID
		where year in ('2011','2012','2013','2014')
		group by stateCodes
        order by ROUND(AVG(UnhealthyDays),2) DESC;
        
        
# 3 Do coastal states consume or produce more hydro energy?	
	SELECT State,
		CASE WHEN (HydroP2010-HydroC2010) > 0 THEN "Produced More" ELSE "Consumed More"  END AS "2010 Status",
		CASE WHEN (HydroP2011-HydroC2011) > 0 THEN "Produced More" ELSE "Consumed More"  END AS "2011 Status",
		CASE WHEN (HydroP2012-HydroC2012) > 0 THEN "Produced More" ELSE "Consumed More"  END AS "2012 Status",
		CASE WHEN (HydroP2013-HydroC2013) > 0 THEN "Produced More" ELSE "Consumed More"  END AS "2013 Status",
		CASE WHEN (HydroP2014-HydroC2014) > 0 THEN "Produced More" ELSE "Consumed More"  END AS "2014 Status"
    from state_data as sd
		join consumption_data as cd
			on sd.StateCode = cd.StateCodes
        join production_data as pd
			on sd.StateCode = pd.StateCodes
    where Coast = 1
    order by StateCode;
    
#4 Which States produced the most Hydro energy overall?
SELECT State, (HydroP2010+HydroP2011+HydroP2012+HydroP2013+HydroP2014) as "Hydro Production", sd.Coast,sd.Great_Lakes
    from state_data as sd
        join production_data as pd
			on sd.StateCode = pd.StateCodes
    group by StateCode
    order by (HydroP2010+HydroP2011+HydroP2012+HydroP2013+HydroP2014) DESC
    limit 5;
        
#5  Which States consumed the most Hydro energy overall?
SELECT State, (HydroC2010+HydroC2011+HydroC2012+HydroC2013+HydroC2014) as "Hydro Consumption", sd.Coast,sd.Great_Lakes
    from state_data as sd
        join consumption_data as cd
			on sd.StateCode = cd.StateCodes
    group by StateCode
    order by (HydroC2010+HydroC2011+HydroC2012+HydroC2013+HydroC2014) DESC
    limit 5;



/* Stored Programs*/ 

# First Stored Function 
USE _team15aqi;

DELIMITER //

CREATE FUNCTION latitudelongitude1 (longitude DEC(10,5))
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE LatLong INT;

SELECT latitude
INTO LatLong
FROM AQI_locations
WHERE latitude = longitude;

RETURN(LatLong);

END //

DELIMITER ;


SELECT latitudelongitude1(1);

SELECT latitude, longitude
FROM AQI_locations;

# Second Stored Function

USE _team15aqi;

DELIMITER //

CREATE FUNCTION Ccoal2010_2014 (CoalC2010 INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE CCoal INT;

SELECT CONCAT(CoalC2011, " ", CoalC2012, " ", CoalC2013, " ", CoalC2014) 
INTO CCoal
FROM consumption_data;

RETURN(CCoal);

END //

DELIMITER ;

USE _team15aqi;

DELIMITER //

CREATE FUNCTION Chydro2010_2014 (HydroC2010 INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE CHydro INT;

SELECT CONCAT(HydroC2011, " ", HydroC2012, " ", HydroC2013, " ", HydroC2014) 
INTO CHydro
FROM consumption_data;

RETURN(CHydro);

END //

DELIMITER ;

USE _team15aqi;

DELIMITER //

CREATE FUNCTION Cnatgas2010_2014 (NatGasC2010 INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE CNatGas INT;

SELECT CONCAT(NatGasC2011, " ", NatGasC2012, " ", NatGasC2013, " ", NatGasC2014) 
INTO CNatGas
FROM consumption_data;

RETURN(CNatGas);

END //

DELIMITER ;

USE _team15aqi;

DELIMITER //

CREATE FUNCTION CLPG2010_2014 (LPGC2010 INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE CLPG INT;

SELECT CONCAT(LPGC2011, " ", LPGC2012, " ", LPGC2013, " ", LPGC2014) 
INTO CLPG
FROM consumption_data;

RETURN(CLPG);

END //

DELIMITER ;

USE _team15aqi;

DELIMITER //

CREATE FUNCTION Prodcoal2010_2014 (CoalP2010 INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE CoalProd INT;

SELECT CONCAT(CoalP2011, " ", CoalP2012, " ", CoalP2013, " ", CoalP2014) 
INTO CoalProd
FROM Production_data;

RETURN(CoalProd);

END //

DELIMITER ;

USE _team15aqi;

DELIMITER //

CREATE FUNCTION Prodhydro2010_2014 (HydroP2010 INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE HydroProd INT;

SELECT CONCAT(HydroP2011, " ", HydroP2012, " ", HydroP2013, " ", HydroP2014) 
INTO HydroProd
FROM production_data;

RETURN(HydroProd);

END //

DELIMITER ;



/* Select Statements using stored programs */
USE aqi;
 
delimiter //

CREATE PROCEDURE totRDeath	(IN state varchar(10), out totalRDeath float)
BEGIN
	select format(sum(RDEATH2011 + RDEATH2012 + RDEATH2013 + RDEATH2014),2) as totalRDeath from censusdata
		where StateCodes= state;
END //

delimiter ;

set @totalRDeath = 0;
call totRDeath('CO', @totalRDeath);
select @totalRDeath; 

delimiter //

delimiter //

CREATE PROCEDURE totCoalC	(IN state varchar(10), out totalCoalC int)
BEGIN
	select format(sum(coalC2010 + coalC2011  + coalC2012 + coalC2013 + coalC2014 ),2) as totalCoalC from consumptiondata
		where StateCodes= state;
END //

delimiter ;
set @totalCoalC = 0;
call totCoalC('CO', @totalCoalC);
select @totalCoalC; 


/* Stored procedure: Total 4 Year Coal Consumption Per State */
delimiter //

CREATE PROCEDURE totCoalC	(IN state VARCHAR(10), OUT totalCoalC INT)
BEGIN
	SELECT FORMAT(SUM(CoalC2010 + CoalC2011  + CoalC2012 + CoalC2013 + CoalC2014 ),2) AS totalCoalC FROM consumption_data
		WHERE StateCodes= state;
END //

delimiter ;

# Call to stored procedure
SET @totalCoalC = 0;
CALL totCoalC('CO', @totalCoalC);


/* Create a trigger */ 

use _team15aqi;

drop trigger if exists delete_after_aqilocation_delete;

# create a trigger for when a Location ID is deleted from the aqi_locations table, the same location id and all associated rows are deleted from the measurments and categories tables as well.
DELIMITER $$
	CREATE TRIGGER delete_after_aqilocation_delete
	AFTER DELETE ON aqi_locations 
	FOR EACH ROW
	BEGIN
		DELETE FROM categories WHERE categories.locationid = old.locationid;
		DELETE FROM measurements WHERE measurements.locationid = old.locationid;
	END$$
DELIMITER ;
    
# Delete location ID from the aqi_locations table
#DELETE FROM aqi_locations where locationID = '1';

# See if the trigger deleted all rows for location id 1 on the categories table
#select * from categories where locationID = '1';

# See if the trigger deleted all rows for location id 1 on the measurements table
#select * from measurements where locationID = '1';

# insert into aqi_locations values ('1','AK','Alaska','Aleutians East',55.324675,-160.508331);
# insert into categories values('1', '2010','102','102','0','0','0','0','0');
# insert into categories values('1', '2011','101','100','1','0','0','0','0');
# insert into categories values('1', '2012','116','116','0','0','0','0','0');
# insert into categories values('1', '2013','105','105','0','0','0','0','0');
# insert into categories values('1', '2014','105','104','1','0','0','0','0');
# insert into measurements values ('1',	'2010',	'34',	'17',	'8',	'0',	'0',	'0',	'0',	'102',	'0');
# insert into measurements values ('1',	'2011',	'52',	'22',	'11',	'0',	'0',	'0',	'0',	'101',	'0');
# insert into measurements values ('1',	'2012',	'36',	'20',	'10',	'0',	'0',	'0',	'0',	'116',	'0');
# insert into measurements values ('1',	'2013',	'35',	'19',	'9',	'0',	'0',	'0',	'0',	'105',	'0');
# insert into measurements values ('1',	'2014',	'56',	'19',	'9',	'0',	'0',	'0',	'0',	'105',	'0');


