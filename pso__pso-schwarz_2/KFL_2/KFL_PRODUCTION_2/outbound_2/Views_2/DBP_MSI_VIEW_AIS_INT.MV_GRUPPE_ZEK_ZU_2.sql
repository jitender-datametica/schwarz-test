CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_zek_zu_2 (gruppe_id, mandant_id, anz_mandant, zek_id
, alle_zek_fg) AS SELECT gruppe_id,
 mandant_id,
 COUNT(mandant_id) OVER (PARTITION BY CAST(gruppe_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS anz_mandant,
 zek_id,
 alle_zek_fg
FROM kfl_production_dbp_security.gruppe_zek_zu_2 AS V01;