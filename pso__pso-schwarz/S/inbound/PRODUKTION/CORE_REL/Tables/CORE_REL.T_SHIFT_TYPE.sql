--==============================================================
-- Table: T_SHIFT_TYPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SHIFT_TYPE
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SHIFT_TYPE (
   SHIFT_TYPE_ID                       NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the production shift type',
   SHIFT_TYPE_DESCR                    VARCHAR(250)    NOT NULL COMMENT 'Name for the production shift type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_SHIFT_TYPE PRIMARY KEY (SHIFT_TYPE_ID) NOT ENFORCED
 )  COMMENT= 'Table for describing the different shift types. Source - filled manually. The Schwarz Production divides its working day into different shifts, which have shift types e.g. morning / late / night shift. Timerange of a shift can vary.';

