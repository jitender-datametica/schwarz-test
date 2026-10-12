--==============================================================
-- Table: T_DIM_MOVEMENT_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MOVEMENT_TYPE_1
   generated from Powerdesigner on Thursday, November 18, 2021 12:29:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MOVEMENT_TYPE_1 (
   MOVEMENT_TYPE_ID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the movement type',
   MOVEMENT_TYPE_DESCR                 VARCHAR(50)     NOT NULL COMMENT 'Name for the movement type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'
)COMMENT = 'Minor Dimension - for describing the different types of material movement. It states if material is going into production line as a ressource or beeing outputted as a produced material. Source - extracted from t_booking_1 attribute (persistency of a degenerated dimension).';

