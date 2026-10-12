CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_mov_item_supplier_act_1 (client_id, item_sid, sup_sid, dat_formdate) AS
SELECT client_id,
 item_sid,
 sup_sid,
 dat_formdate
FROM ldl_p_lew_core.t_wawi_mov_item_supplier_act_1;