-- sammel_ladung_fg=0 Direktlieferung und sammel_ladung_fg=1 Sammel

-- Bei der Direktlieferungen wird direkt angezeigt, bei Sammel der Trasportdienstleister

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_anlieferart_2 (mandant_id, anlieferart_id,
anlieferart_bez) AS SELECT BV.mandant_id,
  CASE
  WHEN BV.sammel_ladung_fg = 0
  THEN SUBSTR(CAST(-1 AS STRING), 1, 40)
  ELSE BV.belos_adresse_spedition_id
  END AS anlieferart_id,
 MAX(CASE
   WHEN BV.sammel_ladung_fg = 0
   THEN 'direkt'
   ELSE BA.adress_name
   END) AS anlieferart_bez
FROM kfl_production_dbp_msi_view3_materialized.mv_belos_vorgang_2 AS BV
 INNER JOIN kfl_production_dbp_view.v_belos_adresse_2 AS BA ON BV.mandant_id = BA.mandant_id AND BV.belos_adresse_spedition_id
    = BA.belos_adresse_id
GROUP BY BV.mandant_id,
 anlieferart_id;