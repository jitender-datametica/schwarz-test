CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_land_spr_1 AS SELECT t0.land_id,
 V2.mandant_id,
 t0.`1` AS land_bez,
 t0.`1` AS land_bez_de,
 COALESCE(t0.`2`, t0.`1`) AS land_bez_cz,
 COALESCE(t0.`3`, t0.`1`) AS land_bez_pl,
 COALESCE(t0.`4`, t0.`1`) AS land_bez_md,
 COALESCE(t0.`5`, t0.`1`) AS land_bez_sk,
 COALESCE(t0.`6`, t0.`1`) AS land_bez_hr,
 COALESCE(t0.`7`, t0.`1`) AS land_bez_ro,
 COALESCE(t0.`8`, t0.`1`) AS land_bez_bg
FROM (SELECT *
  FROM kfl_production_dbp_view.v_land_1 PIVOT (MAX(COLLATE(land_bez,'')) FOR mandant_id IN (1 AS `1`, 2 AS `2`, 3 AS `3`, 4 AS `4`, 5
     AS `5`, 6 AS `6`, 7 AS `7`, 8 AS `8`))) AS t0
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V2 ON TRUE;