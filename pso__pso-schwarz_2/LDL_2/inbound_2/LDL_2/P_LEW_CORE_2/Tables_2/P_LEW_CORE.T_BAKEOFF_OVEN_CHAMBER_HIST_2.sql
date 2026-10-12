/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_hist_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:38:50
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_HIST_2 (
   bakeoff_oven_chamber_sid            NUMBER(38,0)     NOT NULL COMMENT 'The unique surrogate identifier for a Chamber in the Oven.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.',
   store_loc_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION_2 (eindeutig ueber alle Laender / Mandanten hinweg).',
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT.',
   ip_address_nr                       VARCHAR(100)     COMMENT 'The IP address_2 for the Baking Oven Chamber.',
   bakeoff_oven_chamber_name           VARCHAR(100)     NOT NULL COMMENT 'Name of the baking oven chamber.',
   bakeoff_oven_pos_nr                 NUMBER(38,0)     NOT NULL COMMENT 'A numerical Number which identifies the position of the oven in the store. Most stores will have up to three different ovens.',
   bakeoff_oven_chamber_pos_cd         VARCHAR(100)     NOT NULL COMMENT 'Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven. ',
   bakeoff_oven_chamber_serial_nr      VARCHAR(100)     COMMENT 'The serial number for the Oven chamber.',
   bakeoff_oven_chamber_model_name     VARCHAR(100)     COMMENT 'The name for the model type of the Oven chamber.',
   bakeoff_oven_chamber_construction_year NUMBER(38,0)     COMMENT 'The year of construction for the Oven chamber.',
   bakeoff_oven_chamber_eow_dt          DATE             COMMENT 'End of Warranty Date of the oven chamber.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_BAKEOFF_OVEN_CHAMBER_HIST PRIMARY KEY (bakeoff_oven_chamber_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Table contains historized data for oven chambers which are located in a store and send event data. Several chambers (mostly two) can be grouped into an oven,';
