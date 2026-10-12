/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CONTAINER_EXPORT_REPORT_1
   generated from Powerdesigner on Freitag, 2. August 2024 08:21:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_container_export_report_1 (
container_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the container.'),
container_export_report_name STRING(100) NOT NULL
OPTIONS(description='Natural Key/Business Key - A milestone is an event in the container lifecycle. Table contains the list of the possible event results'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
container_export_status_nr STRING(50) NOT NULL
OPTIONS(description='Descriptive Attribute - A milestone is an event in the container lifecycle. Table contains the list of the possible events'),
container_export_dt DATE OPTIONS(description='The date when the report for this container is generated'),
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
OPTIONS(description='Fact table - Transactional Events - Transaction - Container was listed in an important system generated export. - Source - VMT');