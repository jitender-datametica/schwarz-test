
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_agg_store_day_item_adv_asis_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT ADV.client_id,
 ADV.loc_sid_wh,
 ADV.wh_id,
 ADV.loc_sid_store_move_to,
 ADV.src_itemgrp_int_cd AS itemgroup_int_id,
 ADV.item_sid AS item_id,
 ADV.dat_adv,
 ADV.dat_formdate,
 ADV.qty_sales,
 ADV.qty_delivery,
 ADV.qty_stc_real,
 COALESCE(rep.repeat_fg, 0) AS rep_repeat_fg,
 ADV.timestamp_mod
FROM ldl_p_lew_bil_ac.v_agg_store_day_item_adv_asis_2 AS ADV
 INNER JOIN ldl_p_lew_core_ac.v_item_2 AS I ON ADV.client_id = I.client_id AND ADV.item_sid = I.item_sid
 LEFT JOIN (SELECT I2.client_id,
   A.wh_loc_sid,
   I2.src_orig_item_nr,
   I2.src_dat_valid_from,
   A.dat_adv,
   A.repeat_fg
  FROM ldl_p_lew_mart_msi.v_adv_item_advertising_2 AS A
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS I2 ON A.client_id = I2.client_id AND A.item_sid = I2.item_sid
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I2.client_id AS STRING), CAST(A.wh_loc_sid AS STRING), I2.src_orig_item_nr
        , I2.src_dat_valid_from, A.dat_adv ORDER BY A.dat_dayend IS NULL, A.dat_dayend, A.repeat_fg IS NULL DESC, A.repeat_fg
        DESC)) = 1) AS rep ON I.client_id = rep.client_id AND ROUND(SAFE_CAST(rep.src_orig_item_nr AS BIGNUMERIC), 0) =
      ROUND(SAFE_CAST(I.src_orig_item_nr AS BIGNUMERIC), 0) AND I.src_dat_valid_from = rep.src_dat_valid_from AND ADV.loc_sid_wh
     = rep.wh_loc_sid AND ADV.dat_adv = rep.dat_adv;


