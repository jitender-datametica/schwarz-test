/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup_modularization_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_FAMILYGROUP_MODULARIZATION_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CLIENT',
   item_fam_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 FAMILYGROUP;
            CBX: Item.ldlArticleGroup.custText1;
            ESB: cbxItem.itemFamilyGroup.code;
            ',
   buying_list_type_id                 NUMBER(38,0)     NOT NULL COMMENT 'Artikelart WAWI',
   active_from_dt                      DATE             NOT NULL COMMENT 'start day the assortment container is assigned to a store
            WAWI: C1045_VALID_FROM',
   active_to_dt                        DATE             COMMENT 'end day the item_2 is assigned to a container for a certain warehouse
            WAWI: C1045_VALID_TO',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_FAMILYGROUP_MODULARIZATION PRIMARY KEY (item_fam_grp_sid, buying_list_type_id, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'information about which item_2 family group is mandatory to be maintained in a container
             WAWI: T1043_CONTAINER_GROUPS_2';

