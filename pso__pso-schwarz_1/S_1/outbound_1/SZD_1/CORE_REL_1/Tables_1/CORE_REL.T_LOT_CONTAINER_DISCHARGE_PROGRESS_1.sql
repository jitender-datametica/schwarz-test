/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_CONTAINER_DISCHARGE_PROGRESS_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_container_discharge_progress_1 (
lot_product_instance_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
container_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the container.'),
discharge_dt DATE NOT NULL OPTIONS(description='Timestamp of event'),
loaded_carton_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Measure - Total amount of cartons loaded in the container'),
discharged_carton_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Measure - Total amount of undamaged, non-sample cartons unloaded in the container'),
damaged_carton_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Measure - Count of damaged cartons (usually some are squished, wet etc)'),
sample_carton_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Measure - Count of sample cartons: usually 2-5 cartons per container are used for quality sampling and are destroyed afterwards'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_product_instance_group_sid, container_resource_item_sid, discharge_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - In the process of moving containers from Asia to the destination warehouse, where they are finally unloaded and palletized, the “unloading state” defines the “clusters” of unloading the contained cartons.              Some can be damaged, some can be marked as cancelled, so the entity contains the info about how many cartons are actually available for further processing. - Source - VMT');