/* --------------------------------------------------------------------------------
   DDL for table: t_assortment_container
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_assortment_container (
assortment_container_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key container.            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and             T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL            '),
container_client_id BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key CLIENT            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY '),
assortment_container_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the assortment container in the source system            WAWI:T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (assortment_container_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. assortment container, virtual container to allow warehouses to modularize the assortment             WAWI: T1041_ITEMCONTAINER_HEAD');