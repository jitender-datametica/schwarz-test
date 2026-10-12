CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_platzierungswg_wgliste_1 (mandant_id, sok_platzierungswg_id
, sok_wg_liste) AS SELECT t2.mandant_id,
 t2.platzierungswg_id AS sok_platzierungswg_id,
 STRING_AGG(t2.wg_id0, ',' ORDER BY t2.wg_id IS NULL, t2.wg_id) AS sok_wg_liste
FROM (SELECT PWG.mandant_id,
   PWG.platzierungswg_id,
   WG.wg_id,
   CAST(WG.wg_id AS STRING) AS wg_id0,
   ',' AS `A11864`
  FROM kfl_production_dbp_view.v_wg_per_1 AS WG
   INNER JOIN kfl_production_dbp_view.v_l_platzierungswg_1 AS PWG ON WG.mandant_id = PWG.mandant_id AND WG.platzierungswg_id
      = PWG.platzierungswg_id
  WHERE WG.arthiertyp_id = 2
   AND WG.dat_bis = DATE '9999-12-31'
  GROUP BY PWG.mandant_id,
   PWG.platzierungswg_id,
   WG.wg_id) AS t2
GROUP BY t2.mandant_id,
 t2.platzierungswg_id;