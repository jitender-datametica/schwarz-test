CREATE OR REPLACE TABLE szd_production_core.t_fact_lot_milestone_progress_2 (
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
lowest_container_detail_status_cd STRING(50) NOT NULL
OPTIONS(description='Derrived attribute - lowest status_2 code of a conatiner this lot travels in'),
progress_changed_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Event Timestamp of the last milestone date that changed'),
latest_actual_departure_dt DATE
OPTIONS(description='Date of actual time of departure from port of Loading for lot milestone_cd =\"trans_atd\"'),
latest_actual_arrival_dt DATE
OPTIONS(description='Date of actual time of arrival at port of discharge for lot milestone_cd =\"tans_ata\"'),
latest_estimated_departure_dt DATE
OPTIONS(description='Date of estimated time of departure from port of Loading for lot milestone\"etd_in_lot\"'),
latest_estimated_arrival_dt DATE
OPTIONS(description='Date of estimated time of arrival at port of discharge for lot milestone_cd =\"eta_in_lot\"'),
latest_cargo_ready_by_supplier_dt DATE
OPTIONS(description='Latest date for lot milestone with lot_milestone_cd =\"cargo_ready_by_supplier\"'),
latest_shipment_release_dt DATE
OPTIONS(description='Latest date for lot milestone with lot_milestone_cd =\"shipment_release\"'),
latest_official_delivery_week_start_dt DATE
OPTIONS(description='Date that describes the earliest official delivery week of a country_2 from the lot'),
latest_owim_offical_delivery_week_start_dt DATE
OPTIONS(description='Date that describes the earliest official delivery week of owim to a country_2 from the lot'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
latest_destination_customs_clearance_dt DATE
OPTIONS(description='latest date for the lot_milestone_cd =\"destination_customs_clearance\"'),
latest_destination_customs_clearance_result_cd STRING(50)
OPTIONS(description='latest result code corresponding to the latest milestone for destination_customs_clearance'),
latest_quality_approved_dt DATE
OPTIONS(description='Latest date for the lot with milestone for lot_milestone_cd =\'quality_approved\''),
latest_container_arrival_domestic_terminal_dt DATE
OPTIONS(description='Latest date of all containers connected to a lot if all containers have a date for the container milestone\'eu_container_arrival_domestic_terminal\''),
latest_container_goods_in_warehouse_dt DATE
OPTIONS(description='Latest date of all containers connected to a lot if all containers have a date for the container milestone\'eu_container_goods_in_warehouse\''),
PRIMARY KEY (lot_product_instance_group_sid, lowest_container_detail_status_cd, progress_changed_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Snapshot_2 - Granularity - lot - Aggregate - aggregates the lots milestones over time to track the latest state of a lot with status_2 and date information of milestones reached in pivoted form - Source - VMT');