CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_vtg_quote_cross AS SELECT V01.verteilgebiet_uid,
 v02.kjwo,
 CAST(NULL AS NUMERIC) AS verteil_quote
FROM kfl_production_dbp_view.v_geku_verteilgebiet AS V01
 INNER JOIN (SELECT DISTINCT kjwo
  FROM kfl_production_dbp_view.v_tag
  WHERE akt_wo BETWEEN - 10 AND 0) AS v02 ON TRUE
WHERE STRPOS(V01.verteilgebiet_bez, 'TIP') <> 0
 AND (V01.verteilgebiet_uid, CAST(v02.kjwo AS BIGNUMERIC)) NOT IN (SELECT (verteilgebiet_uid, kjwo)
   FROM kfl_production_dbp_msi_view_vis.ts_geku_verteilgebiet_quote)
UNION ALL
SELECT verteilgebiet_uid,
 kjwo,
 verteil_quote
FROM kfl_production_dbp_msi_view_vis.ts_geku_verteilgebiet_quote;