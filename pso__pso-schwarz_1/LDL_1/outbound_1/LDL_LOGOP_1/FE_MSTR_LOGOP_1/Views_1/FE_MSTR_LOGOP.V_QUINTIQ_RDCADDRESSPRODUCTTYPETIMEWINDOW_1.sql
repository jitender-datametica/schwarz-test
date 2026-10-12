/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_RDCADDRESSPRODUCTTYPETIMEWINDOW_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_rdcaddressproducttypetimewindow_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_country
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), wh_id OPTIONS(description='Warehouse ID'),
addressid OPTIONS(description='ID of the address_1'), dayofweek
OPTIONS(description='Day of week indicator 67 means weekend (Saturday + Sunday) & 1 means Monday'), endtime
OPTIONS(description='Pattern: (d+ day(s)? )?d+:dd:dd'), istypepreferred
OPTIONS(description='True if this time window is a time window of type preferred'), producttypeid
OPTIONS(description='ID of the product type'), starttime OPTIONS(description='Pattern: (d+ day(s)? )?d+:dd:dd'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT *
FROM ldl_logop_data.t_quintiq_rdcaddressproducttypetimewindow_1;