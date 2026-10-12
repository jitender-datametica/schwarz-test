create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_ADDRESS_DEMOGRAPHICS_HIST_1 cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	ADDR_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ADDRESS_1;',
	INHABITANTS_10MIN_BY_CAR_CNT NUMBER(38,0) COMMENT 'number of inhabitants within 10 minutes driving distance to the address_1 by car; IMS_ESB: inhabitants_car 10min count; object.gis.population.car type=10',
	INHABITANTS_5MIN_BY_CAR_CNT NUMBER(38,0) COMMENT 'number of inhabitants within 5 minutes driving distance to the address_1 by car; IMS_ESB: inhabitants_car 5min count; object.gis.population.car type=5',
	INHABITANTS_500M_CNT NUMBER(38,0) COMMENT 'number of inhabitants within 500 meters radius to the address_1; IMS_ESB: inhabitants 1000 meters count; object.gis.population.radius type=500',
	INHABITANTS_1000M_CNT NUMBER(38,0) COMMENT 'number of inhabitants within 1000 meters radius to the address_1; IMS_ESB: inhabitants 1000 meters count; object.gis.population.radius type=0',
	INHABITANTS_CITY_CNT NUMBER(38,0) COMMENT 'number of inhabitants within the city the address_1 is located in; IMS_ESB: inhabitants in city count; object.gis.population.city',
	INHABITANTS_CATCHMENT_AREA_CNT NUMBER(38,0) COMMENT 'number of inhabitants within the catchment area of the address_1; IMS_ESB: inhabitants commuting in area count; object.gis.population.draw',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 (\""minus unendlich\"")',
	DWH_VALID_TO DATE NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 (\""plus unendlich\"")',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint PK_T_ADDRESS_DEMOGRAPHICS_HIST primary key (ADDR_SID, DWH_VALID_FROM)
)COMMENT='$Revision: 0000 $. Demographic details per address_1'
;
