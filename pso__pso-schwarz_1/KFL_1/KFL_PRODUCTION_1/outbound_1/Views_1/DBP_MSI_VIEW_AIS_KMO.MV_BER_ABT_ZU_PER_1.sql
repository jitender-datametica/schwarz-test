CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_ber_abt_zu_per_1 (abt_id, ber_id, mandant_id, dat_von,
dat_bis, arthiertyp_id) AS SELECT V01.wg_hierarchie_id AS abt_id,
 V01.wg_hierarchie_mutter_id AS ber_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V01.arthiertyp_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_abt_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_id = V02.abt_id
   
WHERE V01.mandant_id > 1
 AND V01.arthiertyp_id = 10
 AND V01.wg_hierarchie_ebene_id = 2
 AND CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis;