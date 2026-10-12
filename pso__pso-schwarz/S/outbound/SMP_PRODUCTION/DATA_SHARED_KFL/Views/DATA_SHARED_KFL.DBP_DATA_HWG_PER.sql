CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_hwg_per (arthiertyp_id, hwg_id, mandant_id, dat_von,
dat_bis, abt_id, hr_objekt_bereich_id, hr_objekt_bereich_id_de, td_update, td_insert) AS SELECT arthiertyp_id,
 hwg_id,
 mandant_id,
 dat_von,
 dat_bis,
 abt_id,
 hr_objekt_bereich_id,
 hr_objekt_bereich_id_de,
 td_update,
 td_insert
FROM kfl_production_dbp_data.hwg_per;