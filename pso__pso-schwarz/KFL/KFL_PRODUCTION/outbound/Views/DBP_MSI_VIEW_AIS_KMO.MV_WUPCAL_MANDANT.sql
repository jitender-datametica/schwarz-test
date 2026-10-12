CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wupcal_mandant (mandant_id, dat, bonanzahl, bonanzahl_sug
) AS SELECT mandant_id,
 dat,
 SUM(bonanzahl) AS bonanzahl,
 SUM(bonanzahl_sug) AS bonanzahl_sug
FROM kfl_production_dbp_view.v_wupcal
WHERE mandant_id <> 1
GROUP BY mandant_id,
 dat;