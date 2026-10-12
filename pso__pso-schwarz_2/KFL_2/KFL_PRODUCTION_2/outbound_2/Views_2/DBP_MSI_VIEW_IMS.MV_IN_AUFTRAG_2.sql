CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_auftrag_2 AS SELECT AUFTR.mandant_id,
 AUFTR.auftrag_id,
 AUFTR.auftragsart_id,
 COALESCE(AUFTR.techn_platz_id, '') AS techn_platz_id,
  CASE
  WHEN AUFTR.auftragsart_id = '4IHA'
  THEN OBJ.cs_auftrag_prio
  ELSE NULL
  END AS cs_auftrag_prio
FROM kfl_production_dbp_view.v_in_auftrag_2 AS AUFTR
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_objekt_qual_2 AS OBJ ON AUFTR.auftrag_id = OBJ.auftrag_id AND AUFTR
   .mandant_id = OBJ.mandant_id;