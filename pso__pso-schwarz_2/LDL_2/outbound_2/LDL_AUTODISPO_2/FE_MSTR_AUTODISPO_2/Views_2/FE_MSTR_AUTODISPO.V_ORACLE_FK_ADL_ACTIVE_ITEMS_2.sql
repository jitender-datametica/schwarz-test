/* Version: 1.4
	** Author:	Dominik Pfarr
	** Date: 	2024-10-01
	** Changes:	switch to item_Status_all; adjust timestamps again to 12 hr shift; 5 weeks-no weekfilter */
CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_adl_active_items_2 (country_2, cy_week, item_nr,
item_packagecapacity, wh, supplier_nr, active) OPTIONS(DESCRIPTION = `VERSION: 1.4 - REMOVE WEEK FILTER`) AS
/* for DWH_VALID_FROM_TMSP: changes before 12 noon [mod_date] should count for this day 
	for DWH_VALID_TO_TMSP:
	changes after 12 noon [mod_date] count for the day after 
	[adding 12 hrs and substracting 24 hrs to end the previous record 1 day before the new record is valid to avoid double coounting] */
SELECT DSI.country_2,
 C.cy_week,
 DSI.item_nr,
 DSI.item_packagecapacity,
 DSI.supplier_wh AS wh,
 DSI.supplier_nr,
 MAX(DSI.active) AS active
FROM ldl_autodispo_core.t_oracle_v_dim_supplier_item_hist_2 AS DSI
 INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_dim_calendar_date_2 AS C ON C.cal_dt BETWEEN DATE(DATETIME_ADD(DSI.dwh_valid_from_tmsp
    ,INTERVAL 12 HOUR)) AND (DATE(DATETIME_ADD(DSI.dwh_valid_to_tmsp, INTERVAL - 12 HOUR)))
 INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_item_status_all_2 AS DIS ON DSI.country_2 = DIS.country_2 AND DSI.supplier_wh
      = DIS.dis_wh AND DSI.item_nr = DIS.dis_item_nr AND DSI.item_packagecapacity = DIS.dis_packagecapacity
WHERE C.cal_dt <= CURRENT_DATE -- past

 AND DIS.dis_status BETWEEN 5 AND 8 -- only 1 kolli can exist in status_2 6-11 per item_2

GROUP BY DSI.country_2,
 C.cy_week,
 DSI.item_nr,
 DSI.item_packagecapacity,
 DSI.supplier_wh,
 DSI.supplier_nr;