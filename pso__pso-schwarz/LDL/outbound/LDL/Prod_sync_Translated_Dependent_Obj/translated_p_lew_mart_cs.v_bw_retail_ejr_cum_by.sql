CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_retail_ejr_cum_by (client_id, wh_id, cy_month, aspect_id,
item_familygroup_id, subitemgroup_id, subitemgroup_id0, buying_list_type_id, curr_tot_id, currency_iso_cd,
val_ejr_cum_by) AS SELECT *
FROM ldl_p_lew_mart_cs.t_bw_retail_ejr_cum_by;