CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.v_pit_advert_medium_2 AS
SELECT AMD.client_id,
 AMH.dwh_valid_from AS date_valid_from,
 AMH.dwh_valid_to AS date_valid_to,
 AMD.adv_medium_sid,
 AMH.adv_medium_grp_sid,
 AMD.adv_medium_descr AS advert_medium_descr,
 AMH.adv_medium_ignore_fg,
 AMH.adv_medium_delete_fg,
 0 AS adv_medium_grp_lidlplus_fg,
 AMH.dwh_created,
 CAST(AMD.adv_medium_sid * 100 + AMD.client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 CAST(AMH.adv_medium_grp_sid * 100 + AMH.client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid,
 AMD.adv_medium_sort_val AS adv_medium_disp_order_nbr
FROM ldl_p_lew_mart_analytics.t_advert_medium_2 AS AMD
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_medium_hist_2 AS AMH ON AMD.client_id = AMH.client_id AND AMD.adv_medium_sid
      = AMH.adv_medium_sid AND CURRENT_DATE BETWEEN AMH.dwh_valid_from AND AMH.dwh_valid_to AND AMH.adv_medium_delete_fg
    = 0
UNION ALL
SELECT client_id,
 DATE '1900-01-01' AS date_valid_from,
 DATE '9999-12-31' AS date_valid_to,
 CAST(- 2 * adv_medium_grp_sid * client_id AS BIGNUMERIC) AS adv_medium_sid,
 adv_medium_grp_sid,
  'TOT - ' || adv_medium_grp_descr AS advert_medium_descr,
 0 AS adv_medium_ignore_fg,
 0 AS adv_medium_delete_fg,
 0 AS adv_medium_grp_lidlplus_fg,
 dwh_created,
 CAST(- 2 * adv_medium_grp_sid * client_id * 100 + client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 CAST(adv_medium_grp_sid * 100 + client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid,
 adv_medium_grp_sort_val AS adv_medium_disp_order_nbr
FROM ldl_p_lew_mart_analytics.t_advert_medium_group_2 AS AMG;