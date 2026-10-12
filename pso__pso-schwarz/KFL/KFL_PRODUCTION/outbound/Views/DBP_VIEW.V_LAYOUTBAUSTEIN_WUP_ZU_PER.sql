CREATE OR REPLACE VIEW kfl_production_dbp_view.v_layoutbaustein_wup_zu_per AS SELECT mandant_id,
 layoutbaustein_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 aktiv_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.layoutbaustein_wup_zu_per;