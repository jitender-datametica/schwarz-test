CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wupcal_mo_sum AS SELECT wup_id,
 mandant_id,
 nb_id,
 kjmo,
 gjmo,
 anzahl_oeff_tage,
 offen,
 bonanzahl,
 anzahl_lief_tage,
 bonanzahl_gastro
FROM kfl_production_dbp_data.wupcal_mo_sum;