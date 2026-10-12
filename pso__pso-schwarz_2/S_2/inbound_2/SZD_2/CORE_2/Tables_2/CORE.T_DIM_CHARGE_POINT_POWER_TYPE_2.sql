/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGE_POINT_POWER_TYPE_2
   generated from Powerdesigner on Donnerstag, 8. Mai 2025 13:38:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGE_POINT_POWER_TYPE_2 (
   CHARGE_POINT_POWER_TYPE_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charging power type.',
   CHARGE_POINT_POWER_TYPE_NAME        VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the charging power type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGE_POINT_POWER_TYPE PRIMARY KEY (CHARGE_POINT_POWER_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The type of the power of a charge point on a charger station. - Source - Manual';
