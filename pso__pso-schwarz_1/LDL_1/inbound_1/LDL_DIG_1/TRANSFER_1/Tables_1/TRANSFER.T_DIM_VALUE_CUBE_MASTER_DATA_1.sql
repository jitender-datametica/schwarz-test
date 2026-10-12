CREATE TABLE transfer.t_dim_value_cube_master_data_1
(
    master_data_field_name  VARCHAR(150)        NOT NULL    COMMENT 'The field name used in the Value Cube and in the Core data model for specific business master data.'
    , field_data_type_descr VARCHAR(50)                     COMMENT 'The data type corresponding to the content of the master data field'
    , field_descr           VARCHAR(500)                    COMMENT 'The description of the master data field, from the Core data model'
	, tmsp_insert           TIMESTAMP_LTZ(9)    NOT NULL    COMMENT 'The point in time when this record was created in the data warehouse.'
	, tmsp_update           TIMESTAMP_LTZ(9)    NOT NULL    COMMENT 'The point in time when this record was last updated.'
    , CONSTRAINT pk_t_dim_vc_master_data PRIMARY KEY ( master_data_field_name ) NOT ENFORCED
) COMMENT = 'This table contains the list of available master data dimensions and attributes, which can be used for querying the Value Cube.'
;