create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_LOT_MILESTONE_PROGRESS (
	LOT_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
	LOWEST_CONTAINER_DETAIL_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'Derrived attribute - lowest status code of a conatiner this lot travels in',
	PROGRESS_CHANGED_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'Event Timestamp of the last milestone date that changed',
	LATEST_ACTUAL_DEPARTURE_DT DATE COMMENT 'Date of actual time of departure from port of Loading for lot milestone_cd = \"trans_atd\"',
	LATEST_ACTUAL_ARRIVAL_DT DATE COMMENT 'Date of actual time of arrival at port of discharge for lot milestone_cd =  \"tans_ata\"',
	LATEST_ESTIMATED_DEPARTURE_DT DATE COMMENT 'Date of estimated time of departure from port of Loading for lot milestone \"etd_in_lot\"',
	LATEST_ESTIMATED_ARRIVAL_DT DATE COMMENT 'Date of estimated time of arrival at port of discharge for lot milestone_cd = \"eta_in_lot\"',
	LATEST_CARGO_READY_BY_SUPPLIER_DT DATE COMMENT 'Latest date for lot milestone with lot_milestone_cd = \"cargo_ready_by_supplier\"',
	LATEST_SHIPMENT_RELEASE_DT DATE COMMENT 'Latest date for lot milestone with lot_milestone_cd = \"shipment_release\"',
	LATEST_OFFICIAL_DELIVERY_WEEK_START_DT DATE COMMENT 'Date that describes the earliest official delivery week of a country from the lot',
	LATEST_OWIM_OFFICAL_DELIVERY_WEEK_START_DT DATE COMMENT 'Date that describes the earliest official delivery week of owim to a country from the lot',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	LATEST_DESTINATION_CUSTOMS_CLEARANCE_DT DATE COMMENT 'latest date for the lot_milestone_cd = \"destination_customs_clearance\"',
	LATEST_DESTINATION_CUSTOMS_CLEARANCE_RESULT_CD VARCHAR(50) COMMENT 'latest result code corresponding to the latest milestone for destination_customs_clearance',
	LATEST_QUALITY_APPROVED_DT DATE COMMENT 'Latest date for the lot with milestone for lot_milestone_cd = ''quality_approved''',
	LATEST_CONTAINER_ARRIVAL_DOMESTIC_TERMINAL_DT DATE COMMENT 'Latest date of all containers connected to a lot if all containers have a date for the container milestone ''eu_container_arrival_domestic_terminal''',
	LATEST_CONTAINER_GOODS_IN_WAREHOUSE_DT DATE COMMENT 'Latest date of all containers connected to a lot if all containers have a date for the container milestone ''eu_container_goods_in_warehouse''',
	constraint PK_T_FACT_LOT_MILESTONE_PROGRESS primary key (LOT_PRODUCT_INSTANCE_GROUP_SID, LOWEST_CONTAINER_DETAIL_STATUS_CD, PROGRESS_CHANGED_TMSP)
)COMMENT='Fact table - Transactional Snapshot - Granularity - lot - Aggregate - aggregates the lots milestones over time to track the latest state of a lot with status and date information of milestones reached in pivoted form - Source - VMT'
;