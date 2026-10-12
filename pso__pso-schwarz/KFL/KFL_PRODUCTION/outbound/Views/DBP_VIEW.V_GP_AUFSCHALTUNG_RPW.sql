CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_aufschaltung_rpw AS SELECT mandant_id,
 gp_id,
 hgp_id,
 dat_aufschaltung
FROM kfl_production_dbp_data.gp_aufschaltung_rpw;