CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_aktion_ww_datum_2 (aktion_id, mandant_id, dat_von, dat_bis,
ww_kjwo, dat) AS SELECT V01.aktion_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V02.kjwo AS ww_kjwo,
 V02.dat
FROM kfl_production_dbp_view.v_aktion_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis AND V02.akt_kj BETWEEN -
   2 AND 0;