CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_pit_advert_medium_grp AS SELECT client_id,
 DATE '1900-01-01' AS date_valid_from,
 DATE '9999-12-31' AS date_valid_to,
 adv_medium_grp_sid,
 adv_medium_grp_descr AS advert_medium_grp_descr,
 adv_medium_grp_sort_val AS adv_medium_grp_disp_order_nbr,
 0 AS adv_medium_ignore_fg,
 0 AS adv_medium_delete_fg,
 0 AS adv_medium_grp_lidlplus_fg,
 dwh_created,
 CAST(adv_medium_grp_sid * 100 + client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid
FROM ldl_p_lew_mart_analytics.t_advert_medium_group AS AMG;