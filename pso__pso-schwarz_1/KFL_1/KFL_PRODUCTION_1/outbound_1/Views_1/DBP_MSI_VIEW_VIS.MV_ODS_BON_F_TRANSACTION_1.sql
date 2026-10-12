CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_transaction_1 (bon_id, bon_dat, wup_id, mandant_id,
kasse_nr, bon_beginn, cancel_fg, transaction_name, bon_nr, suspended_fg, training_fg, kpos_kasse_typ, kassensystem_name
, kpos_transaction_name, kpos_transaction_status) AS SELECT BT.bon_id,
 BT.bon_dat,
 WUP.aktuell_wup_id AS wup_id,
 BT.mandant_id,
 BT.kasse_nr,
 BT.bon_beginn,
 BT.cancel_fg,
 BT.transaction_name,
 BT.bon_nr,
 BT.suspended_fg,
 BT.training_fg,
 BT.kpos_kasse_typ,
 BT.kassensystem_name,
 BT.kpos_transaction_name,
 BT.kpos_transaction_status
FROM kfl_production_dbp_v_ods.v_ods_bon_transaction_1 AS BT
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON BT.mandant_id = WUP.mandant_id AND BT.wup_id = WUP.wup_id;