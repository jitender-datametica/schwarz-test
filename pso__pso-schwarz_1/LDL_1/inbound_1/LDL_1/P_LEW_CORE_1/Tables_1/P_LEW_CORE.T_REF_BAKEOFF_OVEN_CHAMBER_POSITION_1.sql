/* --------------------------------------------------------------------------------
   DDL for table: t_ref_bakeoff_oven_chamber_position_1
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:40:37
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BAKEOFF_OVEN_CHAMBER_POSITION_1 (
   bakeoff_oven_chamber_pos_cd         VARCHAR(100)     NOT NULL COMMENT 'Alphanumeric Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.',
   bakeoff_oven_chamber_pos_descr      VARCHAR(250)     NOT NULL COMMENT 'Description of the Code which identifies if the chamber is placed on "top" or on the "bottom" in the oven.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BAKEOFF_OVEN_CHAMBER_POSITION PRIMARY KEY (bakeoff_oven_chamber_pos_cd) NOT ENFORCED 
)  COMMENT = 'Table contains information about the possible places where the oven chamber is placed in the oven.';
