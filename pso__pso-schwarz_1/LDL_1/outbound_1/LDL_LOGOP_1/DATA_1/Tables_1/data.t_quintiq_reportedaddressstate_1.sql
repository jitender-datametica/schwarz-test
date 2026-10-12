/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddressstate_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedaddressstate_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
pallet_pos_additional_dist BIGNUMERIC(38,10)
OPTIONS(description='The additional distance per pallet positions that had to be travelled to visit this address_1 during the considered tour_1'),
address_id STRING(512) NOT NULL OPTIONS(description='Stores the address_1 ID'),
calendar_week BIGNUMERIC(38,0) OPTIONS(description='CalendarWeek'),
delivery_dt DATE NOT NULL OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
oneway_fg BOOL OPTIONS(description='The address_1 state where the resources are dismounted for one way tours'),
temp_fg BOOL OPTIONS(description='Indicates if this is a temporary reported address_1 state'),
pallet_pos_dlv_cnt BIGNUMERIC(38,10)
OPTIONS(description='This calculates the number of pallet positions that is delivered to an address_1 during a tour_1'),
tour_dist_without_addr BIGNUMERIC(38,10)
OPTIONS(description='The resulting tour_1 distance if the considered address_1 was not part of the tour_1'),
reportedtourgid STRING(512) NOT NULL OPTIONS(description='GID of the reported tour_1'),
reportedtourid STRING(512) OPTIONS(description='ID of the reported tour_1'),
arrivalactualtelematics DATETIME OPTIONS(description='Actual arrival time at this address_1, received from Telematics'),
arrivalestimatedtelematics DATETIME
OPTIONS(description='Estimated arrival time at this address_1, received from Telematics'),
departureactualtelematics DATETIME
OPTIONS(description='Actual departure time at this address_1, received from Telematics'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, address_id, reportedtourgid, delivery_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='AddressStates that belong to tours and routes that are reported AddressStates contains all actions within the same sequence at a certain address_1');