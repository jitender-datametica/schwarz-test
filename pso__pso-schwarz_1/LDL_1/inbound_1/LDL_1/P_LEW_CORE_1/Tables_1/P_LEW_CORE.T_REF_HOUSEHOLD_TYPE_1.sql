/* --------------------------------------------------------------------------------
   DDL for table: t_ref_household_type_1
   generated from Powerdesigner on Donnerstag, 25. Januar 2024 15:22:12
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_HOUSEHOLD_TYPE_1 (
   household_type_id                   NUMBER(38,0)     NOT NULL COMMENT 'ID of the household type in which the customer lives.',
   household_type_descr                VARCHAR(250)     NOT NULL COMMENT 'Description of the household type in which the customer lives.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_REF_HOUSEHOLD_TYPE PRIMARY KEY (household_type_id) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the various IDs for the type of the household.';