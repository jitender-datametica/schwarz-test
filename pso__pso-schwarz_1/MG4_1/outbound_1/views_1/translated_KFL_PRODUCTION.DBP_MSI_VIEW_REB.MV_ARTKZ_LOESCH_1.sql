CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_artkz_loesch_1 (loesch_id, loesch_bez, mandant_id, spr_id) AS
SELECT loesch_id,
  CASE
  WHEN loesch_bez = 'system generated'
  THEN 'ZEK_1 Status_1 aktiv'
  ELSE loesch_bez
  END AS loesch_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_loesch_1
WHERE mandant_id = 1
 AND spr_id = 22
 AND loesch_id NOT IN ('ZB', 'ZL', 'ZR', 'ZV', '01', '01', '02');