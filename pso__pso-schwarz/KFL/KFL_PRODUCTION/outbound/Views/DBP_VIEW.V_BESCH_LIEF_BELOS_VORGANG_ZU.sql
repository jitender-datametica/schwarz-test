CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_lief_belos_vorgang_zu AS SELECT mandant_id,
 lief_beleg_id,
 kj_lief_beleg,
 dat_lief_soll,
 belos_vorgang_id,
 transportation_unit_id,
 dat_leistung,
 versandstelle_id,
 lief_prefix
FROM kfl_production_dbp_data.besch_lief_belos_vorgang_zu;