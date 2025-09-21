use aircraft_dataset

-- 1️. Aircraft Weight Efficiency Analysis

-- Purpose: Identify which aircraft carry the most payload relative to their Maximum Takeoff Weight (MTOW).

SELECT top 10 Aircraft_Model, Cargo_Capacity_kg, Number_of_Passengers,
       Maximum_Takeoff_Weight_kg,
       CAST((Cargo_Capacity_kg + (Number_of_Passengers*75)) AS FLOAT)/Maximum_Takeoff_Weight_kg AS Payload_MTOW_Ratio
FROM aircraft
ORDER BY Payload_MTOW_Ratio DESC;

-- 2️. Fuel Efficiency Proxy

--Purpose: Determine aircraft fuel per passenger, a proxy for range efficiency.

SELECT top 10 Aircraft_Model, Fuel_Capacity_liters, Number_of_Passengers,
       CAST(Fuel_Capacity_liters AS FLOAT)/Number_of_Passengers AS Fuel_per_Passenger
FROM aircraft
ORDER BY Fuel_per_Passenger ASC;


-- 3️. Center of Gravity Risk Analysis

-- Purpose: Flag aircraft with narrow or extreme CG limits that require careful loading.

SELECT Aircraft_Model, Center_of_Gravity_Limits
FROM aircraft
WHERE Center_of_Gravity_Limits NOT LIKE '25%-35%' AND Center_of_Gravity_Limits NOT LIKE '35%-45%';

-- 4️. Wing and Tail Loading Extremes
-- Purpose: Identify aircraft with unusual aerodynamic loads that may affect stability.

SELECT Aircraft_Model, Wing_Loading_kg_m, Tail_Loading_kg_m
FROM aircraft
WHERE Wing_Loading_kg_m > 500 OR Wing_Loading_kg_m < 50
ORDER BY Wing_Loading_kg_m DESC;

-- 5️. Speed vs MTOW Tradeoff
-- Purpose: Explore performance limitations of heavy aircraft.

SELECT Aircraft_Model, Maximum_Takeoff_Weight_kg, Maximum_Speed_knots
FROM aircraft
ORDER BY Maximum_Speed_knots DESC;

-- 6️.High-Capacity Aircraft Clustering
-- Purpose: Categorize aircraft for route planning and fleet composition.

SELECT Aircraft_Model, Number_of_Passengers, Cargo_Capacity_kg,
       CASE
           WHEN Number_of_Passengers < 100 THEN 'Regional'
           WHEN Number_of_Passengers BETWEEN 100 AND 300 THEN 'Medium-Haul'
           ELSE 'Long-Haul'
       END AS Aircraft_Class
FROM aircraft
ORDER BY Aircraft_Class, Number_of_Passengers DESC;

-- 7️. Engine Type vs Maximum Altitude
-- Purpose: Compare operational ceilings between turbofans, turboprops, and others.

SELECT Engine_Type, AVG(Maximum_Altitude_ft) AS Avg_Max_Altitude
FROM aircraft
GROUP BY Engine_Type;

-- 8️. Fuselage Efficiency
-- Purpose: Identify aircraft that carry more passengers per meter of fuselage.

SELECT Aircraft_Model, Fuselage_Length_m, Number_of_Passengers,
       CAST(Number_of_Passengers AS FLOAT)/Fuselage_Length_m AS Passengers_per_m
FROM aircraft
ORDER BY Passengers_per_m DESC;

-- 9️. MTOW vs Fuel Capacity Ratio
-- Purpose: Assess how much of the MTOW is allocated to fuel, a key factor in range design.

SELECT Aircraft_Model, Maximum_Takeoff_Weight_kg, Fuel_Capacity_liters,
       CAST(Fuel_Capacity_liters AS FLOAT)/Maximum_Takeoff_Weight_kg AS Fuel_MTOW_Ratio
FROM aircraft
ORDER BY Fuel_MTOW_Ratio DESC;


-- 10. Multi-Parameter Performance Index
-- Purpose: Rank aircraft by a combination of efficiency, speed, and capacity.

SELECT top 10 Aircraft_Model,
       (CAST(Number_of_Passengers AS FLOAT)/Fuselage_Length_m +
        CAST(Cargo_Capacity_kg AS FLOAT)/Maximum_Takeoff_Weight_kg +
        Maximum_Speed_knots/Maximum_Takeoff_Weight_kg) AS Performance_Index
FROM aircraft
ORDER BY Performance_Index DESC;

-- 11️. Cargo-to-Fuel Efficiency
-- Purpose: Identify aircraft with highest cargo efficiency per liter of fuel.

SELECT top 10  Aircraft_Model, Cargo_Capacity_kg, Fuel_Capacity_liters,
       CAST(Cargo_Capacity_kg AS FLOAT)/Fuel_Capacity_liters AS Cargo_Fuel_Ratio
FROM aircraft
ORDER BY Cargo_Fuel_Ratio DESC;

-- 12️. Passenger-to-Fuel Efficiency
SELECT top 10  Aircraft_Model, Number_of_Passengers, Fuel_Capacity_liters,
       CAST(Number_of_Passengers AS FLOAT)/Fuel_Capacity_liters AS Passengers_Fuel_Ratio
FROM aircraft
ORDER BY Passengers_Fuel_Ratio DESC;

-- 13️. High-Speed Aircraft Identification
-- Purpose: Highlight aircraft capable of exceptional speeds.

SELECT Aircraft_Model, Maximum_Speed_knots, Engine_Type
FROM aircraft
WHERE Maximum_Speed_knots > 500
ORDER BY Maximum_Speed_knots DESC;


-- 14️. Tailored Center of Gravity Analysis
-- Purpose: Identify aircraft with narrow CG limits, high MTOW, and high passenger count.

SELECT Aircraft_Model, Center_of_Gravity_Limits, Maximum_Takeoff_Weight_kg, Number_of_Passengers
FROM aircraft
WHERE Center_of_Gravity_Limits LIKE '20%-30%' AND Maximum_Takeoff_Weight_kg > 200000
ORDER BY Maximum_Takeoff_Weight_kg DESC;


-- 15️. Wing Loading vs Maximum Altitude
SELECT Aircraft_Model, Wing_Loading_kg_m, Maximum_Altitude_ft
FROM aircraft
ORDER BY Wing_Loading_kg_m DESC, Maximum_Altitude_ft DESC;


-- 16️. Engine Type Performance Clustering
SELECT Engine_Type,
       AVG(Maximum_Speed_knots) AS Avg_Speed,
       AVG(Maximum_Altitude_ft) AS Avg_Altitude,
       AVG(Fuel_Capacity_liters) AS Avg_Fuel
FROM aircraft
GROUP BY Engine_Type;

-- 17️. Extreme Payload Aircraft
SELECT Aircraft_Model, Number_of_Passengers, Cargo_Capacity_kg,
       (Cargo_Capacity_kg + Number_of_Passengers*75) AS Total_Payload
FROM aircraft
ORDER BY Total_Payload DESC;

-- 18️. Range Potential Proxy
-- Purpose: Use fuel vs MTOW ratio as a proxy for potential range.

SELECT Aircraft_Model, Fuel_Capacity_liters, Maximum_Takeoff_Weight_kg,
       CAST(Fuel_Capacity_liters AS FLOAT)/Maximum_Takeoff_Weight_kg AS Fuel_MTOW_Ratio
FROM aircraft
ORDER BY Fuel_MTOW_Ratio DESC;

-- 19️. Fuselage Utilization Efficiency
SELECT top 10 Aircraft_Model, Fuselage_Length_m, Number_of_Passengers,
       CAST(Number_of_Passengers AS FLOAT)/Fuselage_Length_m AS Passengers_per_Meter
FROM aircraft
ORDER BY Passengers_per_Meter DESC;


-- 20️. Multi-Factor Performance Index
-- Purpose: Combine payload, speed, and fuel efficiency into one metric.
SELECT top 10 Aircraft_Model,
       (CAST(Number_of_Passengers AS FLOAT)/Fuselage_Length_m +
        CAST(Cargo_Capacity_kg AS FLOAT)/Maximum_Takeoff_Weight_kg +
        Maximum_Speed_knots/Maximum_Takeoff_Weight_kg) AS Performance_Index
FROM aircraft
ORDER BY Performance_Index DESC;