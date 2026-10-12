CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_art_wg_zu_2 (mandant_id, dat_von, art_id, kl_art_id, arthiertyp_id,
wg_id, dat_bis, wug_id) AS SELECT ARTWG.mandant_id,
 ARTWG.dat_von,
 ARTWG.art_id,
 ART.kl_art_id,
 ARTWG.arthiertyp_id,
 ARTWG.wg_id,
 ARTWG.dat_bis,
 ARTWG.wug_id
FROM kfl_production_dbp_data.art_wg_zu_per_2 AS ARTWG
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art_2 AS ART_2 ON ARTWG.art_id = ART.art_id AND ARTWG.dat_bis = ART.dat_bis
   
WHERE ARTWG.dat_bis = DATE '9999-12-31';