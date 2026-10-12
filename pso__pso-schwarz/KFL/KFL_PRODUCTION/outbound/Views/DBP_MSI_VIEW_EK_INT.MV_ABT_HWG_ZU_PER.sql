CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_abt_hwg_zu_per (abt_id, hwg_id, mandant_id, dat_von,
dat_bis, arthiertyp_id) AS SELECT V01.abt_id,
 V02.hwg_id,
 V01.mandant_id,
 V02.dat_von,
 V02.dat_bis,
 V01.arthiertyp_id
FROM kfl_production_dbp_view.v_abt AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_per AS V02 ON V01.mandant_id = V02.mandant_id AND V01.abt_id = V02.abt_id AND
   CURRENT_DATE BETWEEN V02.dat_von AND V02.dat_bis;