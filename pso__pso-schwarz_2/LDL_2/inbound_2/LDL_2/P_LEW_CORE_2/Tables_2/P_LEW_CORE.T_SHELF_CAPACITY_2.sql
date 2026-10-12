CREATE TABLE P_LEW_CORE.T_SHELF_CAPACITY_2 (
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT
            spf_section.EXTDESC21',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM.',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key STORE LOCATION.',
   active_from_dt                      DATE             NOT NULL COMMENT 'The begin date of the validity_2 period of the shelf capacity.',
   active_to_dt                        DATE             COMMENT 'The end date of the validity_2 period of the shelf capacity.',
   pos_nr                              NUMBER(38,0)     COMMENT 'The position number in the OUTDAT type 24.',
   price_label_type_cd                 NUMBER(38,0)     NOT NULL COMMENT 'The code of the price label type (see also t_ref_price_label_type).',
   item_merchandising_type_cd          VARCHAR(100)     COLLATE 'en-ci' COMMENT 'A reference to the table t_item_merchandising_type containing the capacity unit_2 that describes the shelf capacity amount.',
   shelf_capacity_meas                 NUMBER(38,5)     NOT NULL COMMENT 'The number of items regarding to their capacity unit_2 that the shelf can contain.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SHELF_CAPACITY PRIMARY KEY (item_sid, loc_sid_store, active_from_dt) NOT ENFORCED 
)  COMMENT = 'Contains the historized shelf quantities of items per store. This quantity differs from the planned quantities stored in the spaceman tables.';
