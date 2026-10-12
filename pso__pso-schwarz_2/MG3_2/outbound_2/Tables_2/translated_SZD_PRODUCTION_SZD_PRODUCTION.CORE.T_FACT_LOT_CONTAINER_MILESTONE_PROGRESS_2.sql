CREATE OR REPLACE TABLE szd_production_core.t_fact_lot_container_milestone_progress_2 (
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
container_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the container.'),
progress_changed_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Event Timestamp of the last milestone date value that changed'),
container_milestone_progress_detail_cd STRING(50)
OPTIONS(description='Code for a more detailed status_2 of progress of a lot/container'),
container_lpod_pickup_dt DATE
OPTIONS(description='Latest pick-up date of container from LPOD Terminal for container_milestone_cd =\"eu_container_pickup_pod\"'),
container_lpod_pickup_result_cd STRING(50)
OPTIONS(description='Status_2 of Container Pickup from LPOD (e.g. green = picked-up) for container_milestone_cd =\"eu_container_pickup_pod\" associated with container_lpod_pickup_dt'),
container_lpod_pickup_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived attribute - set to true if milestone for container with container_milestone_cd =\"eu_container_pickup_pod\" exists and has a date associated with it'),
container_domestic_terminal_arrival_dt DATE
OPTIONS(description='Latest arrival date of container at the domestic terminal in Europe for container_milestone_cd =\"eu_container_arrival_domestic_terminal\"'),
container_domestic_terminal_arrival_result_cd STRING(50)
OPTIONS(description='Status_2 of ContainerArrival at the domestic terminal in Europe (e.g. green = arrived) for container_milestone_cd =\"eu_container_arrival_domestic_terminal\"'),
container_domestic_terminal_arrival_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived attribute - set to true if milestone for container with container_milestone_cd =\"eu_container_arrival_domestic_terminal\" exists and has a date associated with it'),
container_gas_measurement_dt DATE
OPTIONS(description='Latest date when the gas measurement of a container has taken place for container_milestone_cd =\"eu_container_gas_measurement\"'),
container_gas_measurement_result_cd STRING(50)
OPTIONS(description='Status_2 of gas measurement (e.g. completed = freely measured) for container_milestone_cd =\"eu_container_gas_measurement\"'),
container_gas_measurement_result_evaluation_txt STRING(1000) NOT NULL
OPTIONS(description='Derrived attribute - result of the gas measurement process on latest date'),
container_gas_measurement_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for container with container_milestone_cd =\"eu_container_gas_measurement\" exists and has a date associated with it and related result_evaluation_txt is not\"Open\"'),
container_destination_customs_clearance_dt DATE
OPTIONS(description='Latest date of customs clearance by customs agent  for contanier_milestone_cd =\"eu_container_destination_customs_clearance\"'),
container_destination_customs_clearance_result_cd STRING(50)
OPTIONS(description='Status_2 of customs clearance (e.g. green =customs cleared) for contanier_milestone_cd =\"eu_container_destination_customs_clearance\"'),
container_destination_customs_clearance_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for container with container_milestone_cd =\"eu_container_destination_customs_clearance\" exists and has a date associated with it'),
container_goods_in_warehouse_dt DATE
OPTIONS(description='Date when the goods have been unloaded at the OWIM warehouse for container_milestone_cd =\"eu_container_goods_in_warehouse\"'),
container_goods_in_warehouse_result_cd STRING(50)
OPTIONS(description='Indication whether a container has been already unloaded at the import warehouse for container_milestone_cd =\"eu_container_goods_in_warehouse\"'),
container_goods_in_warehouse_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for container with container_milestone_cd =\"eu_container_goods_in_warehouse\" exists and has a date associated with it'),
container_return_depot_result_dt DATE
OPTIONS(description='Date of empty container returned for container_milestone_cd =\"eu_container_return_depot\"'),
container_return_depot_result_cd STRING(50)
OPTIONS(description='Indication whether a container has been already empty returned for container_milestone_cd =\"eu_container_return_depot\"'),
container_return_depot_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for container with container_milestone_cd =\"eu_container_return_depot\" exists and has a date associated with it'),
lot_actual_departure_dt DATE OPTIONS(description='Date of actual time of departure from port of Loading for atd'),
lot_trans_atd_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for lot with lot_milestone_cd =\"\'trans_atd\" exists and has a date associated with it'),
lot_latest_actual_arrival_dt DATE OPTIONS(description='Date of actual time of arrival at port of discharge for ata'),
lot_trans_ata_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for lot with lot_milestone_cd =\"\'trans_ata\" exists and has a date associated with it'),
lot_latest_estimated_arrival_dt DATE
OPTIONS(description='Date of estimated time of arrival at port of discharge for eta'),
lot_eta_in_lot_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for lot with lot_milestone_cd =\"eta_in_lot\" exists and has a date associated with it'),
lot_latest_estimated_departure_dt DATE
OPTIONS(description='Date of estimated time of departure from port of Loading for etd'),
lot_etd_in_lot_fg BOOL DEFAULT FALSE NOT NULL
OPTIONS(description='Derrived fact - set to true if milestone for lot with lot_milestone_cd =\"etd_in_lot\" exists and has a date associated with it'),
lot_latest_official_delivery_week_start_dt DATE
OPTIONS(description='Date that describes the earliest official delivery week of a country_2 within a container'),
lot_latest_owim_offical_delivery_week_dt DATE
OPTIONS(description='Date that describes the earliest official delivery week of owim to a country_2 within a container'),
lot_latest_cargo_ready_by_supplier_dt DATE
OPTIONS(description='Latest date for lot milestone with lot_milestone_cd =\"cargo_ready_by_supplier\"'),
lot_latest_shipment_release_dt DATE
OPTIONS(description='Latest date for lot milestone with lot_milestone_cd =\"shipment_release\"'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_product_instance_group_sid, container_resource_item_sid, progress_changed_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Snapshot_2 - Granularity - container, lot - Aggregate - aggregates milestones over time of lot and container to track progress of lot and container through their milestones ni pivoted form resulting in a certain status_2 of the combination of them in the system - Source - VMT');