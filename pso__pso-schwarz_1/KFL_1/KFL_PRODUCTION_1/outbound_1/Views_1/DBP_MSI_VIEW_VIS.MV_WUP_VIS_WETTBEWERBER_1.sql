CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_vis_wettbewerber_1 AS SELECT WW.mandant_id,
 WW.nb_id,
 WW.wup_id,
 WW.dat_eroeffnung,
 COALESCE(WB.wb_rang, 0) AS wb_rang,
 COALESCE(WB.wb_name, '') AS wb_name,
 WB.wb_dat_von
FROM kfl_production_dbp_data.wup_1 AS WW
 LEFT JOIN kfl_production_dbp_data.vis_wettbewerber_1 AS WB ON WW.mandant_id = WB.mandant_id AND WW.wup_id = WB.wup_id
WHERE WW.nb_id = 0
 AND WW.dat_von > DATE('1900-01-01')
 AND WW.dat_eroeffnung > DATE('1900-01-01');