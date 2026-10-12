/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_EXPORT_REPORT_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_container_export_report_2 (
container_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the container.'),
container_export_report_name STRING(100) NOT NULL
OPTIONS(description='The name of a export report that can be "P1", "P2", "P3", "P4"'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
container_export_status_nr STRING(50) NOT NULL
OPTIONS(description='Descriptive Attribute - A value indicating the status_2 of the corresponding export report'),
container_export_dt DATE
OPTIONS(description='Descriptive Attribute - The date when the report for this container is generated'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (container_resource_item_sid, dwh_valid_from_tmsp, container_export_report_name) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Container was listed in an important system generated export - Source - VMT');