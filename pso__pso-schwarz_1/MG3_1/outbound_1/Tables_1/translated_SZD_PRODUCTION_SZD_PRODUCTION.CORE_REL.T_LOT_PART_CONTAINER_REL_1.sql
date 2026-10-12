CREATE OR REPLACE TABLE szd_production_core_rel.t_lot_part_container_rel_1 (
lot_part_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
container_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the container.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
shipped_product_qty NUMERIC(29,5) NOT NULL OPTIONS(description='Measure - Shipped Product Quantity'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_part_product_instance_group_sid, container_resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='M:N Relation Entity - A shipment of particular product variant in a container.  - Source - VMT');