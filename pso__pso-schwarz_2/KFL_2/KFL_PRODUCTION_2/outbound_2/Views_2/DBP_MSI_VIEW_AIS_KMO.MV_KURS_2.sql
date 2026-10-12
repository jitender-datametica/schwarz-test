CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_kurs_2 (kurstyp_id, von_wrg_id, nach_wrg_id, dat,
umrechnungskurs) AS SELECT V01.kurstyp_id,
 V01.von_wrg_id,
 V01.nach_wrg_id,
 V02.dat,
 V01.umrechnungskurs
FROM kfl_production_dbp_view.v_kurs_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis;