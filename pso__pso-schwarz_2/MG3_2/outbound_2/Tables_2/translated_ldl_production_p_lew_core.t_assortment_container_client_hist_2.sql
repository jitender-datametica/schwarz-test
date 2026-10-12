
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_assortment_container_client_hist_2 (
client_id INTEGER NOT NULL OPTIONS(description='Surrogate Key CLIENT, (here WAWI client)'),
assortment_container_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key container.\n            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and\n            T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
assortment_container_name STRING(100)
OPTIONS(description='local name of the assortment container in case of a country_2 specific container\n            WAWI: C1041_DESC_NAT'),
assortment_container_descr STRING(1000)
OPTIONS(description='description of the assortment container\n            WAWI: C1041_INFORMATION'),
local_assortment_container_nr INTEGER NOT NULL OPTIONS(description='WAWI:T1041_ITEMCONTAINER_HEAD.C1041_CONTAINER_ID'),
deleted_fg INTEGER NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 (\"minus unendlich\")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 (\"plus unendlich\")'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, assortment_container_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. assortment container related historization of attributes maintained in the countries, virtual container to allow warehouses to modularize the assortment\n          WAWI: T1041_ITEMCONTAINER_HEAD_2, locally maintainde content');
