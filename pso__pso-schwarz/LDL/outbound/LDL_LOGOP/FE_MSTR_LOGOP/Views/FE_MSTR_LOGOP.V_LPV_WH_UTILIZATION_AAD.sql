/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	fe_mstr_logop.V_LPV_WH_UTILIZATION_AAD
Description		|	lpv warehouseutilization - view with additional columns

====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_wh_utilization_aad (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), gang_nr
OPTIONS(description='GR date. Original name - datum'), area_nr
OPTIONS(description='Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH'),
cal_dt OPTIONS(description='REFERENCE DATE'), dwh_updated OPTIONS(description='Record updated at'), total_bins
OPTIONS(description='COUNT OF LOCATION_ID'), bin_capacity
OPTIONS(description='Location capacity. Original name - PLATZ'), bin_capacity_available
OPTIONS(description='Free location capacity. Original name - PLATZ_V'), blocked_bins
OPTIONS(description='Whether the location is currently locked. V = No block. S = Blocked. Original name - SPERRE')) AS
WITH WHX AS (SELECT DISTINCT client_id,
   wh_id,
   location_id,
   location_name,
   CONCAT('AISLE', ' ', SUBSTR(location_id, 1, 2)) AS gang_nr,
   area_nr,
   IF(block_cd = 'S', 1, 0) AS block_cd,
   IF(capacity >= 1000, capacity / 960000, capacity) AS capacity,
   IF(capacity_available >= 1000, capacity_available / 960000, capacity_available) AS capacity_available,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to
  FROM ldl_logop_data.t_lpv_whx AS W
  WHERE area_nr BETWEEN 700 AND 899
   AND NOT deleted_fg) (SELECT t2.client_id,
   t2.wh_id,
   t2.gang_nr,
   t2.area_nr,
   C.cal_dt,
   t2.dwh_updated,
   COUNT(t2.location_id) AS total_bins,
   SUM(t2.capacity) AS bin_capacity,
   SUM(t2.capacity_available) AS bin_capacity_available,
   SUM(t2.block_cd) AS blocked_bins
  FROM WHX AS t2
   INNER JOIN ldl_logop_data.t_cal_calendarday AS C ON C.cal_dt BETWEEN t2.dwh_valid_from AND t2.dwh_valid_to
  WHERE C.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 185 DAY) AND (CURRENT_DATE)
  GROUP BY t2.client_id,
   t2.wh_id,
   t2.gang_nr,
   t2.area_nr,
   C.cal_dt,
   t2.dwh_updated);