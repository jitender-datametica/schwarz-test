/*
    CREATE T_REL_SOURCE_TABLE_VALUE_POSITION_2
*/

CREATE TABLE transfer.t_rel_source_table_value_position_2
(
    source_table         VARCHAR(100) NOT NULL       COMMENT 'Name of the table that is the source of the value cube position.'
    , field_name         VARCHAR(50) NOT NULL        COMMENT 'It is the name of the field in the corresponding source table (eg. PROD_QTY or PACK_QTY).'  
    , value_pos_cd       VARCHAR(10)                  COMMENT 'Identifier of the value cube position. Each metric can be a value cube position.'
	, tmsp_insert        TIMESTAMP_LTZ(9)            COMMENT 'The point in time when this record was created in the data warehouse.'
	, tmsp_update        TIMESTAMP_LTZ(9)            COMMENT 'The point in time when this record was last updated.'
    , CONSTRAINT pk_t_rel_source_table_value_position PRIMARY KEY ( source_table, field_name ) NOT ENFORCED
) COMMENT = 'The relational table holding the name of the source table and of the field associated to the value cube position.'
;