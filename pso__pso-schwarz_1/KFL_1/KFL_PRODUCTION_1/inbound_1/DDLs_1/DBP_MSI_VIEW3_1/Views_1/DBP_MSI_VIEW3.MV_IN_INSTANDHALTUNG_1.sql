CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_INSTANDHALTUNG_1 as
   SELECT
   v01.auftrag_id, v01.mandant_id, v01.instandhaltung_leistungsart_id, v01.in_kunde_id, v01.qual_meldung_id, v01.wart_plan_id, v01.wart_plan_abruf_id, v01.wart_plan_pos_id, v01.dat_bezug, case when v01.wart_plan_id IS NULL then 'nein' else 'ja' end auftrag_aus_wartung
   FROM dbp_view.v_in_instandhaltung_1 v01;