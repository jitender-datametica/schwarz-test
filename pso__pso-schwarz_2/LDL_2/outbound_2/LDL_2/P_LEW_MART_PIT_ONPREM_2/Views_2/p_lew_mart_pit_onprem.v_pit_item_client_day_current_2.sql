CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_item_client_day_current_2 (client_id, dwh_cal_dt, cy_year, cy_month
, iso_year_week, adv_week_id, lang_sid, weekday_nr, weekday_descr, weekday_sdescr, dwh_cal_dt_ldescr, cy_month_descr,
item_sid, item_mstr_sid, item_fam_grp_sid, brand_sid, sub_item_grp_sid, item_grp_int_sid, orig_item_nr, item_descr_int,
item_descr, item_variant_descr_int, item_variant_descr, src_familygrp_id, src_familygrp_cd, item_fam_grp_name,
item_fam_grp_descr, src_subitemgrp_id, src_subitemgrp_cd, sub_item_grp_name, src_itemgrp_int_id, src_itemgrp_int_cd,
item_grp_int_name, item_grp_int_descr, brand_name_int, brand_descr, buying_list_type_id, buying_list_type_descr,
buying_list_type_group_id, buying_list_type_group_descr, listing_type_id, listing_type_descr, listing_type_group_id,
listing_type_group_descr, listing_fg, action_type_id, marke_em_descr, case_size, marke_fg, em_fg) AS SELECT client_id,
 dwh_cal_dt,
 cy_year,
 cy_month,
 cy_week AS iso_year_week,
 adv_week_id,
 lang_sid,
 CAST(FORMAT_DATE('%u', DATE(dwh_cal_dt)) AS INTEGER) AS weekday_nr,
 FORMAT_DATE('%a', DATE(dwh_cal_dt)) AS weekday_descr,
 FORMAT_DATE('%a', DATE(dwh_cal_dt)) AS weekday_sdescr,
 FORMAT_DATE('%a, %b %d , %Y', DATE(dwh_cal_dt)) AS dwh_cal_dt_ldescr,
 FORMAT_DATE('%b-%Y', DATE(dwh_cal_dt)) AS cy_month_descr,
 item_sid,
 item_mstr_sid,
 item_fam_grp_sid,
 brand_sid,
 sub_item_grp_sid,
 item_grp_int_sid,
 orig_item_nr,
 item_name AS item_descr_int,
 COALESCE(item_description, item_name) AS item_descr,
    item_name || ' (' || CAST(ROUND(CAST(case_size AS BIGNUMERIC), 0) AS STRING) || ')' AS item_variant_descr_int,
    COALESCE(item_description, item_name) || ' (' || CAST(ROUND(CAST(case_size AS BIGNUMERIC), 0) AS STRING) || ')' AS
 item_variant_descr,
 src_familygrp_id,
 src_familygrp_cd,
 item_fam_grp_name,
 item_fam_grp_descr,
 src_subitemgrp_id,
 src_subitemgrp_cd,
 sub_item_grp_name,
 src_itemgrp_int_id,
 src_itemgrp_int_cd,
 item_grp_int_name,
 item_grp_int_descr,
 brand_name AS brand_name_int,
 brand_descr,
 buying_list_type_id,
 buying_list_type_descr,
 buying_list_type_group_id,
 buying_list_type_group_descr,
 listing_type_id,
 listing_type_descr,
 listing_type_group_id,
 listing_type_group_descr,
 listing_fg,
 action_type_id,
 derived_brand_type_cd AS marke_em_descr,
 case_size,
  CASE
  WHEN buying_list_type_id IN (1, 3, 5, 7, 9, 11)
  THEN 1
  ELSE 0
  END AS marke_fg,
  CASE
  WHEN buying_list_type_id NOT IN (1, 3, 5, 7, 9, 11)
  THEN 1
  ELSE 0
  END AS em_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_item_client_last_day_2
WHERE action_type_id IN (1, 2, 3);