/*
#-----------------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_itm_day_miss_item_wh
#-----------------------------------------------------------------------------------------
# History:
#  1.1  02.07.2024    Chetana Patil    SPEC0257149 ADO 639226 Add filter on Artikel-Status
#-----------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_day_miss_item_wh
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT A.dwh_cal_dt AS dat_sys,
 A.client_id,
 WH.src_wh_id AS wh_id_pp,
 1 AS aspect_id,
 ITMP.item_sid_map AS item_id,
 COALESCE(ITMP.dwh_orig_item_nr, ITMP.wawi_dwh_orig_item_nr) AS orig_item_nr_pp
FROM ldl_p_lew_core_ac.v_missing_item_wh_day_status AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh AS ITM ON A.item_sid = ITM.item_sid AND A.client_id = ITM.client_id AND
    A.loc_sid = ITM.wh_loc_sid AND A.dwh_cal_dt BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end
WHERE ITM.item_status IN (7, 8)
GROUP BY dat_sys,
 A.client_id,
 wh_id_pp,
 item_id,
 orig_item_nr_pp;


