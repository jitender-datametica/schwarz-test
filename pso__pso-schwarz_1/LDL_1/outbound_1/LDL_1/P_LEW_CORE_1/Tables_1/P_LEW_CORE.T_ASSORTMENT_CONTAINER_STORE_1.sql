/* --------------------------------------------------------------------------------
   DDL for table: t_assortment_container_store_1
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_assortment_container_store_1 (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT (client of the store)'),
assortment_container_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key container.            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and             T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)'),
active_from_dt DATE NOT NULL
OPTIONS(description='start day the assortment container is assigned to a store            WAWI: C1045_VALID_FROM'),
active_to_dt DATE NOT NULL
OPTIONS(description='end day the item_1 is assigned to a container for a certain warehouse            WAWI: C1045_VALID_TO'),
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
PRIMARY KEY (assortment_container_sid, loc_sid_store, active_from_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. information about which container is assigned to which store             WAWI: T1045_CONTAINER_ASSIGNMENT_1');