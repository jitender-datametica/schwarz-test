CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_druckzeitpunkt (bon_id, wup_id, mandant_id,
zeitstempel_druck, bon_booking, dat_booking, bon_ende) AS SELECT A.bon_id,
 WUP.aktuell_wup_id AS wup_id,
 A.mandant_id,
 A.zeitstempel_druck,
 K.bon_booking,
 K.dat_booking,
 K.bon_ende
FROM kfl_production_dbp_msi_v_view.v_ods_bon_abhol_liste AS A
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_kopf AS K ON A.bon_id = K.bon_id AND A.wup_id = K.wup_id AND A.mandant_id
    = K.mandant_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON A.mandant_id = WUP.mandant_id AND A.wup_id = WUP.wup_id;