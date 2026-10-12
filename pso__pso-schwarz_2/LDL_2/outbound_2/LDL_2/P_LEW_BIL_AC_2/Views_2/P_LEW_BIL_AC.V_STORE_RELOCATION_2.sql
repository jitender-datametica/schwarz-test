CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_store_relocation_2 (client_id, loc_sid_store_move_to, loc_sid_store, loc_name,
src_orig_store_nr, move_fg) AS SELECT client_id,
 loc_sid_store_move_to,
 loc_sid_store,
 loc_name,
 src_orig_store_nr,
 move_fg
FROM ldl_p_lew_bil.t_store_relocation_2;