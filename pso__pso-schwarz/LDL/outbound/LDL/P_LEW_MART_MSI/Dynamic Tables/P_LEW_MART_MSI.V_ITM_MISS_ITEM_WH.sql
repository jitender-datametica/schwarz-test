/*
#-----------------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_itm_miss_item_wh
#-----------------------------------------------------------------------------------------
# History:
#  1.1  02.07.2024    Chetana Patil    SPEC0257149 ADO 639226 Add filter on Artikel-Status
#-----------------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_miss_item_wh (
dat_sys DATE,
client_id BIGNUMERIC(38,0),
item_id INTEGER,
orig_item_nr_pp NUMERIC(20,0),
wh_id_pp INTEGER,
end_cd_pp STRING(20),
aspect_id BIGNUMERIC(38,0)
) AS
SELECT A.dwh_cal_dt AS dat_sys,
 A.client_id,
 ITMP.item_sid_map AS item_id,
 COALESCE(ITMP.dwh_orig_item_nr, ITMP.wawi_dwh_orig_item_nr) AS orig_item_nr_pp,
 WH.src_wh_id AS wh_id_pp,
 A.missing_status_cd AS end_cd_pp,
 1 AS aspect_id
FROM ldl_p_lew_core_ac.v_missing_item_wh_day_status AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid
 INNER JOIN ldl_p_lew_bil_ac.v_item_hierarchy AS SIG ON ITMP.item_sid_map = SIG.item_sid AND ITMP.client_id = SIG.client_id
   
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh AS ITM ON A.item_sid = ITM.item_sid AND A.client_id = ITM.client_id AND
    A.loc_sid = ITM.wh_loc_sid AND A.dwh_cal_dt BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end
WHERE (CAST(ROUND(CAST(SIG.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) IN (40 /* TiKo */, 50 /* Kuehlung */, 60
     /* Food TS */, 4 /* TiKo */, 5 /* Kuehlung */, 6 /* Food TS */) OR CAST(ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC)
      , 0) AS BIGNUMERIC) IN (74 /* Bake off */, 78 /* Hot Convenience */))
 AND A.missing_status_cd IN ('f', 'g')
 AND A.missing_item_status_cd IN ('0', 'FEHLT')
 AND ITM.item_status IN (7, 8)
 AND DATE(A.missing_status_end_tmsp) >= A.dwh_cal_dt
QUALIFY (ROW_NUMBER() OVER (PARTITION BY dat_sys, CAST(A.client_id AS STRING), CAST(orig_item_nr_pp AS STRING), wh_id_pp
      ORDER BY A.missing_status_end_tmsp IS NULL, A.missing_status_end_tmsp, A.missing_status_cd IS NULL, A.missing_status_cd
      , A.item_sid IS NULL, A.item_sid)) = 1;