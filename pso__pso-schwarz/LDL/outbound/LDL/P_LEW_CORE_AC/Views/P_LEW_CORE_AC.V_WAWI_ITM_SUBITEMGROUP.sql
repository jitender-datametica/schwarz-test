CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_subitemgroup (client_id, subitemgroup_id, dat_rec_start, dat_rec_end
, mainitemgroup_id, itemgroup_int_id, statisticgroup_id, person_id, person_name, cnt_rcv, diff_rcv, rcv_days, load_id)
AS SELECT client_id,
 subitemgroup_id,
 dat_rec_start,
 dat_rec_end,
 mainitemgroup_id,
 itemgroup_int_id,
 statisticgroup_id,
 person_id,
 person_name,
 cnt_rcv,
 diff_rcv,
 rcv_days,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_subitemgroup;