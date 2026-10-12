CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_auftrag_1 (auftrag_id, mandant_id, auftragsart_id,
geschaeftsbereich_id, in_budget_typ_id, in_massnahme_typ_id, auftrag_typ_id, psp_id, techn_platz_id, werk_id,
phas_techn_abschluss_fg, dat_buch) AS SELECT V01.auftrag_id,
 V01.mandant_id,
 V01.auftragsart_id,
 V01.geschaeftsbereich_id,
 V01.in_budget_typ_id,
 V01.in_massnahme_typ_id,
 V01.auftrag_typ_id,
 V01.psp_id,
 V01.techn_platz_id,
 V01.werk_id,
 V01.phas_techn_abschluss_fg,
 COALESCE(MAX(V02.dat_buch), MAX(V03.dat_start)) AS dat_buch
FROM kfl_production_dbp_view.v_in_auftrag_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_view3.mv_in_auftrag_rm_1 AS V02 ON V01.auftrag_id = V02.auftrag_id AND V01.mandant_id =
   V02.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view3.mv_in_auftrag_pps_1 AS V03 ON V01.auftrag_id = V03.auftrag_id AND V01.mandant_id =
   V03.mandant_id
GROUP BY V01.auftrag_id,
 V01.mandant_id,
 V01.auftragsart_id,
 V01.geschaeftsbereich_id,
 V01.in_budget_typ_id,
 V01.in_massnahme_typ_id,
 V01.auftrag_typ_id,
 V01.psp_id,
 V01.techn_platz_id,
 V01.werk_id,
 V01.phas_techn_abschluss_fg;