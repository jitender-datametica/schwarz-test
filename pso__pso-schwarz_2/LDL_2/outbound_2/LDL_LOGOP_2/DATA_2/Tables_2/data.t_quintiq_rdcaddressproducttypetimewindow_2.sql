/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_rdcaddressproducttypetimewindow_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_rdcaddressproducttypetimewindow_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
addressid STRING(512) NOT NULL OPTIONS(description='ID of the address_2'),
dayofweek STRING(512) NOT NULL
OPTIONS(description='Day of week indicator, 67 means weekend (Saturday + Sunday) & 1 means Monday'),
endtime STRING(512) OPTIONS(description='Pattern: (/d+ day(s)? )?/d+:/d/d:/d/d'),
istypepreferred BOOL OPTIONS(description='True if this time window is a time window of type preferred'),
producttypeid STRING(512) NOT NULL OPTIONS(description='ID of the product type'),
starttime STRING(512) NOT NULL OPTIONS(description='Pattern: (/d+ day(s)? )?/d+:/d/d:/d/d'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, addressid, producttypeid, dayofweek, starttime, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Object type in quintiq is RDCAddressProductTypeTimeWindow');
