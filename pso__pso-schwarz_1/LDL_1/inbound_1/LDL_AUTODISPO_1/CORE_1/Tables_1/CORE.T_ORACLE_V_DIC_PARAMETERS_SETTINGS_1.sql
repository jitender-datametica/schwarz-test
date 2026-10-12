--==============================================================
-- Table: t_oracle_v_dic_parameters_settings_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_dic_parameters_settings_1
   generated from Powerdesigner on Montag, 3. Juni 2024 10:57:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_DIC_PARAMETERS_SETTINGS_1 (
   COUNTRY_1                             VARCHAR(2)      NOT NULL COMMENT 'Country_1, sourcefield: COUNTRY.',
   PARAMETER_ID                        NUMBER(38, 0)   NOT NULL COMMENT 'Unique ID to identify a parameter of an order group; sourcefield: DIC_PARAM_ID.',
   PARAMETER_NAME                      VARCHAR(100)    NOT NULL COMMENT 'Name of the parameter of an order group; sourcefield: DIC_PARAM_NAME.',
   DEFINED_PARAMETER_VALUE             VARCHAR(50)     COMMENT 'The default value of a parameter if no other value was maintained by a user; sourcefield: DIC_DEF_VALUE.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'Start date from when a defined parameter is valid; created in loading process (day of the loading in Snowflake table).',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'Expiration date of a defined parameter; created in loading process (day of the loading in Snowflake table if a new parameter is set; usually set to date unlimited).',
   MOD_DATE                            TIMESTAMP_LTZ   NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date.',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_DIC_PARAMETERS_SETTINGS PRIMARY KEY (country_1, parameter_id) NOT ENFORCED 
)  COMMENT = 'Defined parameters which have influence on calculations in ADF system. Values are uploaded by business via Excel file. Source: Parin/Parin1 table DIC_PARAMETERES_SETTIGNS.';
