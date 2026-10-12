/* --------------------------------------------------------------------------------
   DDL for table: t_address_demographics_hist_2
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_address_demographics_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
addr_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ADDRESS_2;'),
inhabitants_10min_by_car_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of inhabitants within 10 minutes driving distance to the address_2 by car; IMS_ESB: inhabitants_car 10min count; object.gis.population.car type=10'),
inhabitants_5min_by_car_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of inhabitants within 5 minutes driving distance to the address_2 by car; IMS_ESB: inhabitants_car 5min count; object.gis.population.car type=5'),
inhabitants_500m_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of inhabitants within 500 meters radius to the address_2; IMS_ESB: inhabitants 1000 meters count; object.gis.population.radius type=500'),
inhabitants_1000m_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of inhabitants within 1000 meters radius to the address_2; IMS_ESB: inhabitants 1000 meters count; object.gis.population.radius type=0'),
inhabitants_city_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of inhabitants within the city the address_2 is located in; IMS_ESB: inhabitants in city count; object.gis.population.city'),
inhabitants_catchment_area_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of inhabitants within the catchment area of the address_2; IMS_ESB: inhabitants commuting in area count; object.gis.population.draw'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (addr_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Demographic details per address_2');