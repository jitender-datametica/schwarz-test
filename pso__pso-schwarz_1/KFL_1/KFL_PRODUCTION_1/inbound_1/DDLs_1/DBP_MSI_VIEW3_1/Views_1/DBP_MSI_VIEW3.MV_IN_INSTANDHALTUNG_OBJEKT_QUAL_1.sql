CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_INSTANDHALTUNG_OBJEKT_QUAL_1 as
   SELECT
   v01.mandant_id, v01.qual_meldung_id, v01.tp_objekt_id, v01.auftrag_id, v01.techn_platz_id, v01.dat_stoer_beginn
   FROM dbp_view.v_in_instandhaltung_objekt_qual_1 v01
;