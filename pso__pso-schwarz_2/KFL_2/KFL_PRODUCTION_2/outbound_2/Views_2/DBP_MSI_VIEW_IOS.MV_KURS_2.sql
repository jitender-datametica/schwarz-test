CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_kurs_2 (kurstyp_id, von_wrg_id, dat_von, dat_bis,
umrechnungskurs, nach_wrg_id) AS SELECT kurstyp_id,
 von_wrg_id,
 dat_von,
 dat_bis,
 umrechnungskurs,
 nach_wrg_id
FROM kfl_production_dbp_view.v_kurs_2;