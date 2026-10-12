CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_auftrag (auftrag_id, mandant_id, auftragsart_id,
geschaeftsbereich_id, in_budget_typ_id, in_massnahme_typ_id, auftrag_typ_id, psp_id, techn_platz_id, werk_id,
phas_techn_abschluss_fg, auftrag_kurztext, dat_buch) AS SELECT V01.auftrag_id,
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
 V01.auftrag_kurztext,
 COALESCE(MAX(v02.dat_buch), MAX(v03.dat_start)) AS dat_buch
FROM kfl_production_dbp_view.v_in_auftrag AS V01
 LEFT JOIN (SELECT DISTINCT mandant_id,
   auftrag_id,
   co_leistungsart_id,
   storno_fg,
   storno_zaehler,
   dat_buch
  FROM kfl_production_dbp_view.v_in_auftrag_rm) AS v02 ON V01.auftrag_id = v02.auftrag_id AND V01.mandant_id = v02.mandant_id
   
 LEFT JOIN (SELECT auftrag_id,
   mandant_id,
   dat_start,
   auftrag_rm_id,
   auftrag_rm_pos_id,
   dat_planaufloesung
  FROM kfl_production_dbp_view.v_in_auftrag_pps) AS v03 ON V01.auftrag_id = v03.auftrag_id AND V01.mandant_id = v03.mandant_id
   
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
 V01.phas_techn_abschluss_fg,
 V01.auftrag_kurztext;