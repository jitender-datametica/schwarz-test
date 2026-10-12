/* --------------------------------------------------------------------------------
   DDL for table: t_ref_bakeoff_oven_chamber_baking_program_2
   generated from Powerdesigner on Dienstag, 28. Oktober 2025 11:23:03
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BAKEOFF_OVEN_CHAMBER_BAKING_PROGRAM_2 (
   bakeoff_oven_chamber_baking_program_id NUMBER(38,0)     NOT NULL COMMENT 'ID of the baking program to which baking related events in the chamber can be grouped. The ID represents the intended meaning of the program, in some cases the real data may differ from it.',
   bakeoff_oven_chamber_baking_program_name VARCHAR(100)     NOT NULL COMMENT 'Description of the baking program to which baking related events in the chamber can be grouped.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BAKEOFF_OVEN_CHAMBER_BAKING_PROGRAM PRIMARY KEY (bakeoff_oven_chamber_baking_program_id) NOT ENFORCED 
)  COMMENT = 'The table contains information regarding the baking programs of some events that are reportet on an oven chamber.';
