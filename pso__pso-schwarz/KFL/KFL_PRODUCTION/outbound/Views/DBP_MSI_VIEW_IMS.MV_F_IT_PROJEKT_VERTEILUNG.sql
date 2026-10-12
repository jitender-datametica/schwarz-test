CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_f_it_projekt_verteilung (it_plan_ebene_id, it_projekt_id, gj,
berichts_position_it_id, verteilung_quote, verteilung_betrag) AS SELECT it_plan_ebene_id,
 it_projekt_id,
 gj,
 berichts_position_it_id,
 verteilung_quote,
 verteilung_betrag
FROM kfl_production_dbp_view.v_it_projekt_verteilung_laender AS V01
WHERE berichts_position_it_id NOT IN (1, 3, 5, 7, 8, 9, 10, 13, 17, 18, 19, 20, 14, 21)
UNION ALL
SELECT 1 AS it_plan_ebene_id,
 V01.it_projekt_id,
 V01.gj,
 V01.berichts_position_it_id,
 100 AS verteilung_quote,
 V01.plan_betrag AS verteilung_betrag
FROM kfl_production_dbp_view.v_it_projekt_plan_det AS V01
 INNER JOIN (SELECT it_projekt_id,
   gj,
   MAX(plan_revision_id) AS max_revision
  FROM kfl_production_dbp_view.v_it_projekt_plan_det
  GROUP BY it_projekt_id,
   gj) AS v02 ON V01.it_projekt_id = v02.it_projekt_id AND V01.plan_revision_id = v02.max_revision AND V01.gj = v02.gj
WHERE V01.berichts_position_it_id IN (1, 3, 5, 7, 8, 9, 10, 13, 17, 18, 19, 20, 21);