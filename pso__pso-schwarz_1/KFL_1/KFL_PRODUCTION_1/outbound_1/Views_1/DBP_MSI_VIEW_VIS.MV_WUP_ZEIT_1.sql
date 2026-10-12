CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_zeit_1 AS SELECT dat,
 wup_id,
 mandant_id,
 nb_id,
 bonanzahl,
 zeit_stunde,
 zeit_minute,
 umsatz_brutto
FROM kfl_production_dbp_view.v_wup_zeit_1;