CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_sup_spcond_rel_1 (client_id, spcond_rel_id, spcond_rel_head_id,
spcond_rel_detail_id, spcond_rel_head, spcond_rel_detail, dat_dayend, load_id) AS SELECT client_id,
 spcond_rel_id,
 spcond_rel_head_id,
 spcond_rel_detail_id,
 spcond_rel_head,
 spcond_rel_detail,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_sup_spcond_rel_1;