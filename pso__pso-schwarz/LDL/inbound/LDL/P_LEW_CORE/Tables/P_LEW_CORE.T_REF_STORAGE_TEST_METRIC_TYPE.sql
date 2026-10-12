/* --------------------------------------------------------------------------------
   DDL for table: t_ref_storage_test_metric_type
   generated from Powerdesigner on Dienstag, 19. September 2023 16:40:43
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_STORAGE_TEST_METRIC_TYPE (
   storage_test_metric_type_cd         VARCHAR(100)     NOT NULL COMMENT 'Type of the measure for storage tests.',
   storage_test_metric_type_descr      VARCHAR(250)     NOT NULL COMMENT 'Description of the measure types for storage tests.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_STORAGE_TEST_METRIC_TYPE PRIMARY KEY (storage_test_metric_type_cd) NOT ENFORCED 
)  COMMENT = 'Contains a list of measures that is produced in the result of a storage test.
             Source: FTM (manual static mapping)';
