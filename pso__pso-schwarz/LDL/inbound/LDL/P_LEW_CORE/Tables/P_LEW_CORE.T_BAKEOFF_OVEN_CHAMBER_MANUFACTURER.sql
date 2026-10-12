/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber_manufacturer
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:40:02
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_MANUFACTURER (
   bakeoff_oven_chamber_manufacturer_cd VARCHAR(100)     NOT NULL COMMENT 'The unique code for the Manufacturer of the Baking Oven Chamber.',
   bakeoff_oven_chamber_manufacturer_name VARCHAR(100)     NOT NULL COMMENT 'Then name for the Manufacturer of the Baking Oven Chamber.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_BAKEOFF_OVEN_CHAMBER_MANUFACTURER PRIMARY KEY (bakeoff_oven_chamber_manufacturer_cd) NOT ENFORCED 
)  COMMENT = 'The table contains the different Manufacturers of the baking oven chambers.';
