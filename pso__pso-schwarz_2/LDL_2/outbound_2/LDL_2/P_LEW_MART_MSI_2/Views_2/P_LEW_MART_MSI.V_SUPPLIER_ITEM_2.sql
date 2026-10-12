CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_supplier_item_2 AS SELECT client_id,
 item_sid AS item_id,
 sup_sid AS supplier_id,
 MAX(dat_formdate) AS dat_formdate
FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_2
WHERE receipttype_id = 1
GROUP BY client_id,
 item_id,
 supplier_id;