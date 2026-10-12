CREATE TABLE P_LEW_CORE.T_ASSORTMENT_CONTAINER_CLIENT_HIST (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key CLIENT, (here WAWI client)',
   assortment_container_sid            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key container.
            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and 
            T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL',
   assortment_container_name           VARCHAR(100)    COMMENT 'local name of the assortment container in case of a country specific container
            WAWI: C1041_DESC_NAT',
   assortment_container_descr          VARCHAR(1000)   COMMENT 'description of the assortment container
            WAWI: C1041_INFORMATION',
   local_assortment_container_nr       NUMBER(38,0)    NOT NULL COMMENT 'WAWI:T1041_ITEMCONTAINER_HEAD.C1041_CONTAINER_ID',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_ASSORTMENT_CONTAINER_HIST PRIMARY KEY (client_id, assortment_container_sid, dwh_valid_from)
)
COMMENT = '$Revision: 0000 $. assortment container related historization of attributes maintained in the countries, virtual container to allow warehouses to modularize the assortment
          WAWI: T1041_ITEMCONTAINER_HEAD, locally maintainde content';