CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_art_faktor_pal_2 AS SELECT DISTINCT MAW1.mandant_id,
 MAW1.art_id,
 COALESCE(MAW1.paletten_faktor_einh_id, '-') AS einh_pal,
  MARM_PAL.umrech_zaehler / MARM_PAL.umrech_nenner AS faktor_pal
FROM kfl_production_dbp_view.v_art_2 AS MARA_2
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS MAW1_2 ON MARA.mandant_id = MAW1.mandant_id AND MARA.art_id
     = MAW1.art_id AND MAW1.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS MARM_PAL ON MARM_PAL.dat_bis = DATE '9999-12-31' AND
     MAW1.paletten_faktor_einh_id = MARM_PAL.altnv_menge_einh_id AND MAW1.mandant_id = MARM_PAL.mandant_id AND MAW1.art_id
    = MARM_PAL.art_id;