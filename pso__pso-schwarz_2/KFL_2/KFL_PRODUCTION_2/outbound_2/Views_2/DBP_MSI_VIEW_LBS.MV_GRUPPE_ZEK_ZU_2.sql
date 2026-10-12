CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_zek_zu_2 (gruppe_id, mandant_id, anz_mandant, zek_id,
alle_zek_fg) AS SELECT lbs_gruppe_id AS gruppe_id,
 mandant_id,
 COUNT(mandant_id) OVER (PARTITION BY CAST(lbs_gruppe_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS anz_mandant,
 zek_id,
 alle_zek_fg
FROM kfl_production_dbp_security.lbs_gruppe_zek_zu_2 AS V01;