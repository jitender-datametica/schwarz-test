/* --------------------------------------------------------------------------------
   DDL for table: t_bakeoff_oven_chamber
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER (
   bakeoff_oven_chamber_sid            NUMBER(38,0)     NOT NULL COMMENT 'The unique surrogate identifier for a chamber in the Oven.',
   bakeoff_oven_chamber_nr             VARCHAR(100)     NOT NULL COMMENT 'The identifier for the Oven chamber which is unique in combination with the manufacturer and country.',
   bakeoff_oven_chamber_manufacturer_cd VARCHAR(100)     NOT NULL COMMENT 'The unique code for the Manufacturer of the Baking Oven chamber.',
   bakeoff_oven_chamber_country_cd     VARCHAR(100)     NOT NULL COMMENT 'Country Code from the manufacturer where the oven chamber is located.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_BAKEOFF_OVEN_CHAMBER PRIMARY KEY (bakeoff_oven_chamber_sid) NOT ENFORCED 
)  COMMENT = 'Table contains all chambers which are located in a store and sends event data. Several chambers (mostly two) can be grouped in an oven.';
