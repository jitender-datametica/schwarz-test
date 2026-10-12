/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_REL_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juni 2024 14:15:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_REL_1 (
   WH_TRANSPORTATION_UNIT_SID          NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. ',
   WH_TRANSPORTATION_UNIT_NR           VARCHAR(50)     COMMENT 'The unique internal ID for the warehouse transportation unit_1 delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit_1 number by the external transportation service provider (alt_wh_transportation_unit_nr).  In case the alternate warehouse transportation unit_1 number changes, the internal ID will remain the same and there will be another row for the new unique combination of alt_wh_transportation_unit_nr and wh_transportation_unit_nr',
   ALT_WH_TRANSPORTATION_UNIT_NR       VARCHAR(50)     COMMENT 'An alternative unique identifier for the warehouse transportation unit_1 that is maintained manually by the warehouse employees.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_REL PRIMARY KEY (WH_TRANSPORTATION_UNIT_SID) NOT ENFORCED 
)  COMMENT = 'A fact table that stores the relation between the natural key from the system and the alternative one that is maintained manually for warehouse transportation units.';
