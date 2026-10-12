CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_art_vorschlagswert_per_1 (art_id, ausg_menge_einh_id, dat_bis,
dat_von, mandant_id, paletten_faktor_einh_id, zl_kolli_menge_einh_id, sortimentslistenart_id) AS SELECT art_id,
 ausg_menge_einh_id,
 dat_bis,
 dat_von,
 mandant_id,
 SUBSTR(CAST(paletten_faktor_einh_id AS STRING), 1, 5) AS paletten_faktor_einh_id,
 zl_kolli_menge_einh_id,
 sortimentslistenart_id
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND paletten_faktor_einh_id NOT IN ('X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9')
UNION DISTINCT
SELECT V02.art_id,
 V02.ausg_menge_einh_id,
 V02.dat_bis,
 V02.dat_von,
 V02.mandant_id,
 SUBSTR(CAST(ROUND(CAST(CASE
      WHEN MOD(CAST(1 / V03.umrech_faktor AS BIGNUMERIC), CAST(0.1 AS NUMERIC)) < 0.05
      THEN CAST(1.0 / V03.umrech_faktor AS BIGNUMERIC) - MOD(CAST(1.0 / V03.umrech_faktor AS BIGNUMERIC), CAST(0.1 AS NUMERIC)
        )
      ELSE CAST(1.0 / V03.umrech_faktor AS BIGNUMERIC) - MOD(CAST(1.0 / V03.umrech_faktor AS BIGNUMERIC), CAST(0.1 AS NUMERIC)
         ) + 0.1
      END AS BIGNUMERIC), 0) AS STRING), 1, 6) AS paletten_faktor_einh_id,
 V02.zl_kolli_menge_einh_id,
 V02.sortimentslistenart_id
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V02
 INNER JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS V03 ON V02.art_id = V03.art_id
WHERE V02.paletten_faktor_einh_id IN ('X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9')
 AND V02.art_id = V03.art_id
 AND V02.mandant_id = V03.mandant_id
 AND V02.paletten_faktor_einh_id = V03.altnv_menge_einh_id
 AND V02.dat_bis = DATE '9999-12-31'
 AND V03.dat_bis = DATE '9999-12-31';