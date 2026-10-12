CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_auftrag_rm_pos_1 (mandant_id, auftrag_id, auftrag_kurztext,
werk_id, co_leistungsart_id, storno_fg, storno_zaehler, dat_buch, teil_end_rm, auftrag_rm_pos_id, auftragsart_id,
tp_objekt_id) AS SELECT DISTINCT IN_AUF.mandant_id,
 IN_AUF.auftrag_id,
 IN_AUF.auftrag_kurztext,
 IN_AUF.werk_id,
 COALESCE(IN_AUF_RM.co_leistungsart_id, '-1') AS co_leistungsart_id,
 COALESCE(IN_AUF_RM.storno_fg, 0) AS storno_fg,
 IN_AUF_RM.storno_zaehler,
 IN_AUF_RM.dat_buch,
 IN_AUF_RM.teil_end_rm,
 IN_AUF_RM.auftrag_rm_pos_id,
 IN_AUF.auftragsart_id,
 COALESCE(INST.tp_objekt_id, -1) AS tp_objekt_id
FROM kfl_production_dbp_view.v_in_auftrag_1 AS IN_AUF
 LEFT JOIN kfl_production_dbp_view.v_in_auftrag_rm_1 AS IN_AUF_RM ON IN_AUF.auftrag_id = IN_AUF_RM.auftrag_id AND IN_AUF.mandant_id
    = IN_AUF_RM.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_1 AS INST ON IN_AUF.auftrag_id = INST.auftrag_id AND IN_AUF.mandant_id
    = INST.mandant_id;