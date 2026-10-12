CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_wme_ame_2 AS SELECT mandant_id,
 aktion_id,
 aktionsart_id,
 dat_von,
 dat_bis,
 zusatzinfo
FROM kfl_production_dbp_data.aktion_wme_ame_2;