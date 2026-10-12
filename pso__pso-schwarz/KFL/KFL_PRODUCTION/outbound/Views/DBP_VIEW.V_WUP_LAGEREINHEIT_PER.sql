CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_lagereinheit_per AS SELECT mandant_id,
 lagereinheit_id,
 datzeit_von,
 datzeit_bis,
 wup_id,
 nb_id,
 lagernummer_id,
 lagertyp_id,
 dat_letzte_bewegung,
 spurnummer,
 lager_einheiten_typ,
 system_id,
 lagerplatz_id
FROM kfl_production_dbp_data.wup_lagereinheit_per;