--==============================================================
-- Table: t_oracle_v_fk_parameters_settings
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_parameters_settings
   generated from Powerdesigner on Montag, 3. Juni 2024 11:00:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_FK_PARAMETERS_SETTINGS (
   COUNTRY                             VARCHAR(2)      NOT NULL COMMENT 'Country, sourcefield: COUNTRY.',
   PARAMETER_DATE                      DATE            NOT NULL COMMENT 'Date on which the saved order group settings in ADF were valid; sourcefield: PAM_DATE',
   PARAMETER_ID                        NUMBER(38, 0)   NOT NULL COMMENT 'Unique ID to identify a parameter of an order group; sourcefield: PAM_OG_PARAM_ID',
   WH_NR                               NUMBER          NOT NULL COMMENT 'Warehouse number that is connected to the order group; sourcefield: PAM_WH_NR',
   ORDER_GROUP_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'Unique ID to identify an order group; sourcefield: PAM_OG_ID',
   ORDER_GROUP_NAME                    VARCHAR(100)    NOT NULL COMMENT 'Name of the order group; sourcefield: PAM_OG_NAME',
   ORDER_GROUP_ACTIVE_FG               NUMBER          NOT NULL COMMENT 'Status of an order group set in ADF system. Active=1 inactive=0; sourcefield: PAM_ACTIVE',
   ADF_PARAMETER_VALUE                 VARCHAR(50)     COMMENT 'Value that was maintained in ADF system by a user for a specific order group setting (parameter); sourcefield: PAM_OG_VALUE.',
   CALCULATIONMETHOD                   NUMBER(38, 0)   COMMENT 'Calculation method is used to assign an order group to a set of items (e.g. Ambient, Tiko etc). 1 = Ambient, 2 = Mopro, 3 = Tiko, 4 = Bake-Off, 6 = Fresh Bread; sourcefield: PAM_CALCULATIONMETHOD',
   MOD_DATE                            TIMESTAMP_LTZ   NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date.',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   SNFLK_INSERT_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   SNFLK_UPDATE_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_PARAMETERS_SETTINGS PRIMARY KEY (country, parameter_id, parameter_date, wh_nr, order_group_id) NOT ENFORCED 
)  COMMENT = 'Parameters which have influence on calculations in ADF system. Values are generated in ADF system. Source: Parin/Parin1 table FK_PARAMETERS_SETTINGS.';
