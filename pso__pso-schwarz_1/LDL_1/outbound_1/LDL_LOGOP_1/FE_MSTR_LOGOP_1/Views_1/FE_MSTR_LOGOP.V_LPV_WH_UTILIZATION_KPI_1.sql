/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	fe_mstr_logop.V_LPV_WH_UTILIZATION_KPI_1
Description		|	lpv warehouseutilization - view with KPIs
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_wh_utilization_kpi_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), gang_nr
OPTIONS(description='GR date. Original name - datum'), area_nr
OPTIONS(description='Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH'),
cal_dt OPTIONS(description='REFERENCE DATE'), dwh_updated OPTIONS(description='Record updated at'), total_bins
OPTIONS(description='COUNT OF LOCATION_ID'), bin_capacity
OPTIONS(description='Location_1 capacity. Original name - PLATZ'), bin_capacity_available
OPTIONS(description='Free location_1 capacity. Original name - PLATZ_V'), blocked_bins
OPTIONS(description='Whether the location_1 is currently locked. V = No block. S = Blocked. Original name - SPERRE')) AS
SELECT *
FROM ldl_logop_fe_mstr_logop.v_lpv_wh_utilization_aad_1;