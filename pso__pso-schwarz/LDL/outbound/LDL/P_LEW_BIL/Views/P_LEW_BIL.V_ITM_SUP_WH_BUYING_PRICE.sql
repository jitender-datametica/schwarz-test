

CREATE OR REPLACE VIEW ldl_p_lew_bil.v_itm_sup_wh_buying_price AS SELECT client_id,
 loc_sid AS wh_loc_sid,
 item_sid,
 sup_sid,
 MAX(CASE
   WHEN min_pur_valid_from >= ilh_valid_from
   THEN min_pur_valid_from
   ELSE ilh_valid_from
   END) AS dat_rec_start,
 DATE_SUB(DATE_ADD(MIN(CASE
     WHEN max_pur_valid_to <= ilh_valid_to
     THEN max_pur_valid_to
     ELSE ilh_valid_to
     END), INTERVAL 1 DAY), INTERVAL 1 DAY) AS dat_rec_end,
 MAX(CASE
   WHEN min_pur_valid_from >= ilh_valid_from
   THEN min_pur_valid_from
   ELSE ilh_valid_from
   END) AS dat_valid_from,
 DATE_SUB(DATE_ADD(MIN(CASE
     WHEN max_pur_valid_to <= ilh_valid_to
     THEN max_pur_valid_to
     ELSE ilh_valid_to
     END), INTERVAL 1 DAY), INTERVAL 1 DAY) AS dat_valid_until,
 CAST(NULL AS DATE) AS dat_valid_until_group,
 curr_sid,
 CAST(NULL AS INTEGER) AS group_nr,
 CAST(NULL AS STRING) AS delivery_item_cd,
 SUBSTR(CAST(shelflife_cust_val AS STRING), 1, 20) AS dur_shelflife_cust,
 ROUND(CAST(shelflife_cust_cd AS BIGNUMERIC), 0) AS period_id_shelflife_cust,
 SUBSTR(CAST(shelflife_loc_val AS STRING), 1, 20) AS dur_shelflife_store,
 ROUND(CAST(shelflife_loc_cd AS BIGNUMERIC), 0) AS period_id_shelflife_store,
 SUBSTR(CAST(shelflife_vz_val AS STRING), 1, 20) AS dur_shelflife_wh,
 ROUND(CAST(shelflife_vz_cd AS BIGNUMERIC), 0) AS period_id_shelflife_wh,
 condition_val AS price_buying,
 CAST(NULL AS BIGNUMERIC) AS price_buying_special,
 CAST(NULL AS BIGNUMERIC) AS currency_nr_special,
 CAST(NULL AS STRING) AS origin_country_cd,
 CAST(NULL AS BIGNUMERIC) AS load_id
FROM (SELECT A.client_id,
   A.item_sid,
   A.sup_sid,
   A.loc_sid,
   B.condition_val,
   B.curr_sid,
   ILH.shelflife_cust_val,
   ILH.shelflife_cust_cd,
   ILH.shelflife_loc_val,
   ILH.shelflife_loc_cd,
   ILH.shelflife_vz_val,
   ILH.shelflife_vz_cd,
   A.dwh_valid_from AS pur_valid_from,
   A.dwh_valid_to AS pur_valid_to,
   ILH.dwh_valid_from AS ilh_valid_from,
   ILH.dwh_valid_to AS ilh_valid_to,
   MIN(A.dwh_valid_from) AS min_pur_valid_from,
   MAX(A.dwh_valid_to) AS max_pur_valid_to
  FROM ldl_p_lew_core_ac.v_purchase_info_hist AS A
   INNER JOIN ldl_p_lew_core_ac.v_purchase_condition_hist AS B ON A.client_id = B.client_id AND A.pur_cond_sid = B.pur_cond_sid
     
   LEFT JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist AS ILH ON A.client_id = ILH.client_id AND A.item_sid = ILH
       .item_sid AND A.loc_sid = ILH.loc_sid AND CAST(ldl_p_lew_bil.check_overlap(A.dwh_valid_from, A.dwh_valid_to, ILH.dwh_valid_from, ILH.dwh_valid_to) AS BOOL)
    
   INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client AS MIG ON A.client_id = MIG.client_id AND MIG.migrated_fg = 1
  GROUP BY A.client_id,
   A.item_sid,
   A.sup_sid,
   A.loc_sid,
   B.condition_val,
   B.curr_sid,
   ILH.shelflife_cust_val,
   ILH.shelflife_cust_cd,
   ILH.shelflife_loc_val,
   ILH.shelflife_loc_cd,
   ILH.shelflife_vz_val,
   ILH.shelflife_vz_cd,
   pur_valid_from,
   pur_valid_to,
   ilh_valid_from,
   ilh_valid_to) AS dt_in
GROUP BY client_id,
 item_sid,
 sup_sid,
 loc_sid,
 condition_val,
 curr_sid,
 shelflife_cust_val,
 shelflife_cust_cd,
 shelflife_loc_val,
 shelflife_loc_cd,
 shelflife_vz_val,
 shelflife_vz_cd,
 pur_valid_from,
 pur_valid_to,
 ilh_valid_from,
 ilh_valid_to,
 min_pur_valid_from,
 max_pur_valid_to
UNION DISTINCT
SELECT WAWI.client_id,
 WAWI.wh_loc_sid,
 WAWI.item_sid,
 WAWI.sup_sid,
 WAWI.dat_rec_start,
 WAWI.dat_rec_end,
 WAWI.dat_valid_from,
 WAWI.dat_valid_until,
 WAWI.dat_valid_until_group,
 CUR.curr_sid,
 WAWI.group_nr,
 WAWI.delivery_item_cd,
 WAWI.dur_shelflife_cust,
 WAWI.period_id_shelflife_cust,
 WAWI.dur_shelflife_store,
 WAWI.period_id_shelflife_store,
 WAWI.dur_shelflife_wh,
 WAWI.period_id_shelflife_wh,
 WAWI.price_buying,
 WAWI.price_buying_special,
 WAWI.currency_nr_special,
 WAWI.origin_country_cd,
 WAWI.load_id
FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_buying_price AS WAWI
 INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client AS MIG ON WAWI.client_id = MIG.client_id AND MIG.migrated_fg = 0
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency AS WAWI_CUR ON WAWI.client_id = WAWI_CUR.client_id AND WAWI.currency_nr
    = WAWI_CUR.currency_nr
 INNER JOIN ldl_p_lew_core_ac.v_currency AS CUR ON WAWI.client_id = CUR.client_id AND WAWI_CUR.currency_iso_cd = CUR.curr_iso_cd;

