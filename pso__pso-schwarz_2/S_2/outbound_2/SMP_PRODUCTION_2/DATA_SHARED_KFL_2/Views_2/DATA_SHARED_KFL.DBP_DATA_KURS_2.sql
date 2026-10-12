CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_kurs_2 (kurstyp_id, von_wrg_id, dat_von, dat_bis,
umrechnungskurs, nach_wrg_id, td_update, td_insert) AS SELECT kurstyp_id,
 von_wrg_id,
 dat_von,
 dat_bis,
 umrechnungskurs,
 nach_wrg_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.kurs_2;