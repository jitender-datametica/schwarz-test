CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_advert_medium_1 AS SELECT client_id,
 PARSE_DATE('%F', '1900-01-01') AS date_valid_from,
 PARSE_DATE('%F', '9999-12-31') AS date_valid_to,
 advert_medium_sid AS adv_medium_sid,
 advert_medium_group_sid AS adv_medium_grp_sid,
 advert_medium AS advert_medium_descr,
 advert_medium_ignore_fg AS adv_medium_ignore_fg,
 advert_medium_delete_fg AS adv_medium_delete_fg,
 0 AS adv_medium_grp_lidlplus_fg,
 dwh_created,
 CAST(advert_medium_sid * 100 + client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 CAST(advert_medium_group_sid * 100 + client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid,
 advert_medium_sort_val AS adv_medium_disp_order_nr
FROM ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client_1 AS AMD
WHERE advert_medium_delete_fg = 0
UNION ALL
SELECT client_id,
 PARSE_DATE('%F', '1900-01-01') AS date_valid_from,
 PARSE_DATE('%F', '9999-12-31') AS date_valid_to,
 CAST(- 2 * adv_medium_grp_sid * client_id AS BIGNUMERIC) AS adv_medium_sid,
 adv_medium_grp_sid,
  'TOT - ' || adv_medium_grp_descr AS advert_medium_descr,
 0 AS adv_medium_ignore_fg,
 0 AS adv_medium_delete_fg,
 0 AS adv_medium_grp_lidlplus_fg,
 dwh_created,
 CAST(- 2 * adv_medium_grp_sid * client_id * 100 + client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 CAST(adv_medium_grp_sid * 100 + client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid,
 adv_medium_grp_sort_val AS adv_medium_disp_order_nr
FROM ldl_p_lew_mart_pit_onprem.t_advert_medium_group_1 AS AMG;