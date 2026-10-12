CREATE OR REPLACE TABLE szd_production_core.t_fact_lot_lot_part_container_1 (
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
lot_part_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the lot.'),
container_resource_item_sid INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the container.'),
shipping_destination_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying a political country_1 according to ISO 3166.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
lot_nr STRING(50) NOT NULL OPTIONS(description='Business Key - The number which identifies the lot.'),
gtin_nr STRING(50) OPTIONS(description='Descriptive Attribute - GTIN'),
shipped_product_qty NUMERIC(29,5) NOT NULL OPTIONS(description='Fact - additive - Shipped Product Quantity'),
total_shipped_product_qty NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - Total product shipped quantity within lot'),
container_share_pct NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - Container share of product in container'),
total_shipped_container_product_qty NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - Total product shipped quantity within container'),
other_lots_in_container_txt STRING(1000) NOT NULL
OPTIONS(description='Derrived attribute - A list of lot numbers travelling in the same container, can be an empty list'),
other_lots_in_container_cnt INTEGER NOT NULL
OPTIONS(description='Derrived attribute - count of other lots travelling in the same container'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_part_product_instance_group_sid, container_resource_item_sid, lot_product_instance_group_sid,
 dwh_valid_from_tmsp, shipping_destination_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - Transaction - A shipment of particular product variant and it\'s parts in a container to a destination. - Source - VMT');