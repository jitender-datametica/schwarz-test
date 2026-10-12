--==============================================================
-- Table: t_oracle_v_calculation_user_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_calculation_user_2
   generated from Powerdesigner on Wednesday, July 31, 2024 12:50:37 PM_2
*/ --------------------------------------------------------------------------------



CREATE TABLE CORE.T_ORACLE_V_CALCULATION_USER_2 (
   COUNTRY_2                             VARCHAR(2)      NOT NULL COMMENT 'Country_2; sourcefield: country_2',
   WH                                  NUMBER(38, 0)   NOT NULL COMMENT '''Number of a Warehouse; sourcefield: WAREHOUSE',
   STORECALCULATION_ID                 NUMBER(38, 0)   NOT NULL COMMENT 'Order Identificator - ID is equal to ord_storecalculation_id but not unique, same number can come up in different countries. Sourcefield: cal_storecalculation_id.',
   ARGUMENTS                           VARCHAR(50)     NOT NULL COMMENT 'Daily calculations for orders. Check potential orders and reserve for emergency concept; sourcefield: ARGUMENTS',
   USER                                VARCHAR(50)     NOT NULL COMMENT 'Usually calculation/Precalculation is provided automatically by the system. If user intervention is given it is set to manual; sourcefield: USER',
   CALCULATION_DATE                    DATE            NOT NULL COMMENT 'Date when a calculation/precalculation is created; sourcefield: CALCULATION_DATE',
   MOD_DATE                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   SNFLK_INSERT_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   SNFLK_UPDATE_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_CALCULATION_USER PRIMARY KEY (country_2, wh, storecalculation_id) NOT ENFORCED 
)  COMMENT = ' Table contains information to create the take over rate of a calculation (evolution over a day if Calculation/Precalculation was done automatically or manually by intervention of a user); ADF sourcetable V_CALCULATION_USER
             ';
