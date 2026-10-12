CREATE TABLE CORE.T_DIM_MATERIAL_POSITION_TYPE (
   material_pos_type_cd                VARCHAR(5)      NOT NULL COMMENT 'The code for the process type a product can be assigned to (e.g NORM, BANS).',
   material_pos_type_descr             VARCHAR(250)    NOT NULL COMMENT 'The description for the process type a product can be assigned to',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_MATERIAL_POSITION_TYPE PRIMARY KEY (material_pos_type_cd)
)
COMMENT = 'This minor dimension defines the process type a product can be assigned to. This will also the base for determining other fields such as delivery_src_type';
