CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_adv_orig_item_advertising_std_only_1 AS SELECT ADV.client_id,
 COALESCE(L.src_orig_wh_nr, ADV.wh_loc_sid) AS wh_id,
 IIS.orig_item_nr,
 IIS.dat_valid_from,
 ADV.dat_adv,
 ADV.week_adv,
 ADV.repeat_fg,
 CRY.currency_iso_cd,
 1 AS rec_src_fg_std,
 0 AS rec_src_fg_apt
FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_1 AS ADV
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON ADV.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS IIS ON ADV.item_sid = IIS.item_sid AND ADV.client_id = IIS.client_id
   
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS L ON ADV.wh_loc_sid = L.loc_sid AND ADV.client_id = L.client_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ADV.client_id AS STRING), CAST(COALESCE(L.src_orig_wh_nr, ADV.wh_loc_sid) AS STRING)
      , CAST(IIS.orig_item_nr AS STRING), IIS.dat_valid_from, ADV.dat_adv, CRY.currency_iso_cd ORDER BY ADV.dat_dayend
      IS NULL, ADV.dat_dayend)) = 1;