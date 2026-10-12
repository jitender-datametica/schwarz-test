CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_assortment_container (
assortment_container_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key container.\n            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and\n            T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL\n            '),
container_client_id INTEGER
OPTIONS(description='Surrogate Key CLIENT\n            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY '),
assortment_container_nr INTEGER NOT NULL
OPTIONS(description='identifier of the assortment container in the source system\n            WAWI:T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (assortment_container_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. information about which container is assigned to which store\n             WAWI: T1045_CONTAINER_ASSIGNMENT');