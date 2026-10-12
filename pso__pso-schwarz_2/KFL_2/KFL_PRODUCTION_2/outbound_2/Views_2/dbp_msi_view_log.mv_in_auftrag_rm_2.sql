CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_auftrag_rm_2 (mandant_id, auftrag_id, storno_fg,
storno_zaehler, dat_buch, qual_meldung_id) AS SELECT DISTINCT IN_AUF.mandant_id,
 IN_AUF.auftrag_id,
 COALESCE(IN_AUF_RM.storno_fg, 0) AS storno_fg,
 IN_AUF_RM.storno_zaehler,
 IN_AUF_RM.dat_buch,
 IN_OBJ_Q.qual_meldung_id
FROM kfl_production_dbp_view.v_in_auftrag_2 AS IN_AUF
 LEFT JOIN kfl_production_dbp_view.v_in_auftrag_rm_2 AS IN_AUF_RM ON IN_AUF.auftrag_id = IN_AUF_RM.auftrag_id AND IN_AUF.mandant_id
    = IN_AUF_RM.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_objekt_qual_2 AS IN_OBJ_Q ON IN_AUF.auftrag_id = IN_OBJ_Q.auftrag_id
    AND IN_AUF.mandant_id = IN_OBJ_Q.mandant_id;