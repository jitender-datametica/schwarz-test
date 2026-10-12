CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_art_lagefaktor_1 AS SELECT MARM.mandant_id,
 MARM.art_id,
 MAX(MARM.umrech_zaehler / MARM.umrech_nenner) AS lagefaktor
FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS MARM_1
 LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS MAW1_1 ON MARM.mandant_id = MAW1.mandant_id AND MARM.art_id
     = MAW1.art_id AND MARM.dat_bis = MAW1.dat_bis
WHERE MARM.dat_bis = DATE '9999-12-31' AND MARM.mandant_id = 1 AND MARM.altnv_menge_einh_id = MAW1.lage_faktor_einh_id
 OR MARM.mandant_id <> 1 AND MARM.altnv_menge_einh_id IN ('VST', 'LAG')
GROUP BY MARM.mandant_id,
 MARM.art_id;