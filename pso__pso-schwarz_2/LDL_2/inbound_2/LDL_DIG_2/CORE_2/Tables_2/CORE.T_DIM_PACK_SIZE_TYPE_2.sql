CREATE TABLE CORE.t_dim_pack_size_type_2 (
   pack_size_type_cd                   VARCHAR(50)     NOT NULL COMMENT 'The code for the package_2 size type  (Normal , too long, XXL , Heavy etc)',
   pack_size_type_descr                VARCHAR(250)    COMMENT 'A textual description for the package_2 size type',
   PACK_SIZE_HANDLE_GROUP_CD           VARCHAR(5)      COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_pack_size_type PRIMARY KEY (pack_size_type_cd)
   )COMMENT = 'This minor dimension defines the package_2 size type (Normal , too long, XXL , Heavy etc)';
