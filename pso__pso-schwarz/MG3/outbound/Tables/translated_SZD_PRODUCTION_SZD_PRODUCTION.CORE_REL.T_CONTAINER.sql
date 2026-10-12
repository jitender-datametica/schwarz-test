CREATE OR REPLACE TABLE szd_production_core_rel.t_container (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the container.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
container_status_cd STRING(50) NOT NULL OPTIONS(description='The status code for the lot'),
container_id STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - Oversea Container unique identifier in source system'),
container_nr STRING(50) NOT NULL
OPTIONS(description='Descriptive Attribute - Oversea Container serial number, can occur in multiple shippings over time'),
seal_nr STRING(50) NOT NULL OPTIONS(description='Descriptive Attribute - Oversea Container customs seal number'),
spare_units_fg BOOL NOT NULL
OPTIONS(description='Descriptive Attribute - Flag indicating if a container only contains spare units '),
spare_parts_fg BOOL NOT NULL
OPTIONS(description='Descriptive Attribute - Flag indicating if a container only contains spare parts'),
gas_filled_fg BOOL NOT NULL
OPTIONS(description='Descriptive Attribute - Some containers are filled with gas to avoid insects to damage the goods (for example furniture)'),
container_iso_type_cd STRING(50) NOT NULL
OPTIONS(description='The type code that define a container like\"22G0\",\"42G0\" or\"42R1\" and others'),
teu_qty NUMERIC(29,5)
OPTIONS(description='Measure - The size of container in TEU ( 1 TEU = volume representing the loading capacity of a 20 Foot container. Commonly used are containers with 1 or 2 TEU capacity (20” or 40”))'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (resource_item_sid, dwh_valid_to_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - Can contain different articles, but only from the same supplier (mixed container). - Source - VMT');