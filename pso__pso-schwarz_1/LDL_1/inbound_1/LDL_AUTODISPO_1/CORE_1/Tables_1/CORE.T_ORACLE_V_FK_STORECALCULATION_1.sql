--==============================================================
-- Table: t_oracle_v_fk_storecalculation_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_storecalculation_1
   generated from Powerdesigner on Dienstag, 28. Mai 2024 10:05:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_FK_STORECALCULATION_1 (
   COUNTRY_1                             VARCHAR(2)      NOT NULL COMMENT 'Country_1; sourcefield: country_1',
   STORECALCULATION_ID                 NUMBER(38, 0)   NOT NULL COMMENT 'Order Identificator - ID is equal to ord_storecalculation_id but not unique, same number can come up in different countries. Sourcefield: cal_storecalculation_id.',
   ORDER_TYPE                          VARCHAR(100)    NOT NULL COMMENT 'Type of the calculation of an order (for example standard-calc. or Precalc.); Sourcefield: cal_order_type',
   GENERATION_DATE                     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date of the creation of an order; Sourcefield; CAL_GENERATION_DATE',
   MOD_DATE                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield: mod_date',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   SNFLK_INSERT_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process',
   SNFLK_UPDATE_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_STORECALCULATION PRIMARY KEY (country_1, storecalculation_id) NOT ENFORCED 
)  COMMENT = 'Table created to have storeclaclulation on order type level to increase join performance in frontend; Sourcetable fk_storecalculation';
