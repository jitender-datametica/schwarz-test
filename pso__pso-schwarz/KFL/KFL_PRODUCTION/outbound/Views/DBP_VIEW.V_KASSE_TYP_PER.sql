CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kasse_typ_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 kasse_nr,
 dat_von,
 dat_bis,
 kasse_typ_id
FROM kfl_production_dbp_data.kasse_typ_per;