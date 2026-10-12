/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_assortment_container_item_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_WAREHOUSE_ASSORTMENT_CONTAINER_ITEM_2 (
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT (client of the warehouse)',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)',
   loc_sid_wh                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)',
   assortment_container_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key container.
            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and 
            T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL',
   active_from_dt                      DATE             NOT NULL COMMENT 'start day the item_2 is assigned to a container for a certain warehouse
            WAWI: C1047_VALID_FROM',
   active_to_dt                        DATE             NOT NULL COMMENT 'end day the item_2 is assigned to a container for a certain warehouse
            WAWI: C1047_VALID_TO',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_WAREHOUSE_ASSORTMENT_CONTAINER_ITEM PRIMARY KEY (assortment_container_sid, item_sid, loc_sid_wh, active_from_dt, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. information about which warehouse puts which items into which container
             WAWI: T1047_ITEM_CONTAINER_LINK_2';

