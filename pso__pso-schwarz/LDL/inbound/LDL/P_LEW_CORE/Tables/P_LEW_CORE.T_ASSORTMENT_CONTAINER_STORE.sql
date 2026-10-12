/* --------------------------------------------------------------------------------
   DDL for table: t_assortment_container_store
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ASSORTMENT_CONTAINER_STORE (
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT (client of the store)',
   assortment_container_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key container.
            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and 
            T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION (eindeutig ueber alle Laender/Mandanten hinweg)',
   active_from_dt                      DATE             NOT NULL COMMENT 'start day the assortment container is assigned to a store
            WAWI: C1045_VALID_FROM',
   active_to_dt                        DATE             NOT NULL COMMENT 'end day the item is assigned to a container for a certain warehouse
            WAWI: C1045_VALID_TO',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ASSORTMENT_CONTAINER_STORE PRIMARY KEY (assortment_container_sid, loc_sid_store, active_from_dt, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. information about which container is assigned to which store
             WAWI: T1045_CONTAINER_ASSIGNMENT';

