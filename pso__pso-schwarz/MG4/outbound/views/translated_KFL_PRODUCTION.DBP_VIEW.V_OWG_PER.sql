CREATE OR REPLACE VIEW kfl_production_dbp_view.v_owg_per (owg_id, arthiertyp_id, mandant_id, dat_von, dat_bis, hwg_id,
hr_objekt_bereich_id, hr_objekt_bereich_id_de, td_update, td_insert) AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 hwg_id,
 hr_objekt_bereich_id,
 hr_objekt_bereich_id_de,
 td_update,
 td_insert
FROM kfl_production_dbp_data.owg_per;