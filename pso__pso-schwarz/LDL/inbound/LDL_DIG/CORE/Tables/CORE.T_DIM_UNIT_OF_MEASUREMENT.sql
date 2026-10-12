CREATE TABLE CORE.t_dim_unit_of_measurement (
   uom_sid                             NUMBER          NOT NULL COMMENT 'A surrogate key for the unit of measure.',
   uom_cd                              VARCHAR(5)      NOT NULL COMMENT 'A code for the unit of measure.',
   uom_descr                           VARCHAR(100)    COMMENT 'A textual description for the uom_cd written out in group language (German).',
   uom_standard_sid                    NUMBER          COMMENT 'A surrogate key for the standard unit of measure.',
   uom_standard_cd                     VARCHAR(5)      COMMENT 'A code for the standard unit of measure.',
   uom_standard_multipl_meas           NUMBER(38, 10)   COMMENT 'A multiplicator that is used to convert a measure to standard unit of measure',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                  VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_unit_of_measurement PRIMARY KEY (uom_sid)
)COMMENT = 'This minor dimension defines the unit of measure';
