
CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_srg_vc_pk_sid_1 (
vc_pk_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for a particular value cube record.'),
granularity_lvl STRING(100)
OPTIONS(description='The set or combination of attributes defining the granularity level for a value cube record.'),
vc_pk_cd JSON NOT NULL
OPTIONS(description='The primary key code identifier containing the values of corresponding granularity level attributes for a value cube record.'),
vc_ref_dt JSON
OPTIONS(description='The reference date for a particular value cube record, based on the dataset associated busines process'),
vc_fk_attr_cd JSON
OPTIONS(description='The foreign key code reference to additional dimensions for a particular value cube record.'),
vc_master_data_cd JSON
OPTIONS(description='Reference to additional master data dimensions (e.g. product variant dimensions) for a particular value cube record'),
tmsp_insert TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
tmsp_update TIMESTAMP OPTIONS(description='The point in time when this record was last updated.'),
src_table_name STRING(250) OPTIONS(description='The source table behind the latest update of the record')
)
OPTIONS(description='The surrogate table holding information about the value cube records, their different granularity levels and their corresponding additional attributes relationships.');