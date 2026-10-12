/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SURVEY_CODES_MAP_1
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 14:56:28
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SURVEY_CODES_MAP_1 (
   SURV_PLATFORM_CD                    VARCHAR(20)     NOT NULL COMMENT 'Code identifiying the platform (system) used for the surveys (ex Medallia, Netigate ..)',
   SURV_FIELD_NAME                     VARCHAR(100)    NOT NULL COMMENT 'Name of the field which we will be mapping from the source dataset',
   SURV_FIELD_VALUE                    VARCHAR(1000)   NOT NULL COMMENT 'Value of the field which we will be mapping from the source dataset',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   CORE_SCHEMA_FIELD                   VARCHAR(100)    COMMENT 'Name of the field in CORE schema to which the source field will be mapped',
   CORE_SCHEMA_VAL                     VARCHAR(1000)   COMMENT 'Corresponding value in the CORE schema, to which the source value is mapped',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SURVEY_CODES_MAP PRIMARY KEY (SURV_PLATFORM_CD, SURV_FIELD_NAME, SURV_FIELD_VALUE, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Supporting table used to define rules for mapping different codes from source systems to common codes used in the CORE schema (for example mapping of custom product categories used in surveys  to t_dim_product_subgroup.prod_subgroup_cd)';
