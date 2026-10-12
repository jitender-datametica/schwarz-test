--==============================================================
-- Table: T_DIM_MATERIAL_MOVEMENT_TYPE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MATERIAL_MOVEMENT_TYPE_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MATERIAL_MOVEMENT_TYPE_2 (
   MATERIAL_MOVEMENT_TYPE_ID           NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the movement type',
   MATERIAL_MOVEMENT_TYPE_DESCR        VARCHAR(250)    NOT NULL COMMENT 'Name for the movement type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_MATERIAL_MOVEMENT_TYPE PRIMARY KEY (MATERIAL_MOVEMENT_TYPE_ID) NOT ENFORCED
 )  COMMENT= 'Minor Dimension - for describing the different types of material movement. It states if material is going into production line as a ressource or beeing outputted as a produced material. Source - extracted from t_booking_2 attribute (persistency of a degenerated dimension).';

