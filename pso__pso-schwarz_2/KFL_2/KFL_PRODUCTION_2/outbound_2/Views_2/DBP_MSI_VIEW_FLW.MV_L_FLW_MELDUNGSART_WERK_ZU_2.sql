CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_meldungsart_werk_zu_2 (mandant_id, meldungsart_id, werk_id
) AS SELECT mandant_id,
 meldungsart_id,
 werk_id
FROM kfl_production_dbp_view.v_flw_meldungsart_werk_zu_2 AS V01;