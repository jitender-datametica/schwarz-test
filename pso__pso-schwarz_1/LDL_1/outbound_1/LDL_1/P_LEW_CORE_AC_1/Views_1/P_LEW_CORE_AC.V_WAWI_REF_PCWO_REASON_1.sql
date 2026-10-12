CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_pcwo_reason_1 (client_id, pcwo_reason_id, dat_rec_start, dat_rec_end,
pcwo_reason_id_int, pcwo_group_id, pcwo_group_desc, pcwo_active_fg, pcwo_new_group_cd, load_id) AS SELECT client_id,
 pcwo_reason_id,
 dat_rec_start,
 dat_rec_end,
 pcwo_reason_id_int,
 pcwo_group_id,
 pcwo_group_desc,
 pcwo_active_fg,
 pcwo_new_group_cd,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_pcwo_reason_1;