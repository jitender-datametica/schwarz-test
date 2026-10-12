CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_assortment_container_client_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT, (here WAWI client)'),
assortment_container_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key container.            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and             T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
assortment_container_name STRING(100)
OPTIONS(description='local name of the assortment container in case of a country_1 specific container            WAWI: C1041_DESC_NAT'),
assortment_container_descr STRING(1000)
OPTIONS(description='description of the assortment container            WAWI: C1041_INFORMATION'),
local_assortment_container_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='WAWI:T1041_ITEMCONTAINER_HEAD.C1041_CONTAINER_ID'),
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
PRIMARY KEY (client_id, assortment_container_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. assortment container related historization of attributes maintained in the countries, virtual container to allow warehouses to modularize the assortment          WAWI: T1041_ITEMCONTAINER_HEAD_1, locally maintainde content');