CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_kurs (kurstyp_id, von_wrg_id, nach_wrg_id, dat,
umrechnungskurs) AS SELECT V01.kurstyp_id,
 V01.von_wrg_id,
 V01.nach_wrg_id,
 V02.dat,
 V01.umrechnungskurs
FROM kfl_production_dbp_view.v_kurs AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis
WHERE V01.kurstyp_id = 3
 AND V01.von_wrg_id NOT IN ('AUD', 'DEM', 'BGL', 'HRK', 'SIT', 'ROL');