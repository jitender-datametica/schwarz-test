CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_loesch (loesch_id, loesch_bez, mandant_id, spr_id) AS
SELECT loesch_id,
  CASE
  WHEN loesch_bez = 'system generated'
  THEN 'ZEK Status aktiv'
  ELSE loesch_bez
  END AS loesch_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_loesch
WHERE mandant_id = 1
 AND loesch_id NOT IN ('ZB', 'ZL', 'ZR', 'ZV', '01', '01', '02');