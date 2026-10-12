CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_best_ausg_menge_einh_2 (mandant_id, art_id, best_menge_einh_id,
best_umrech_faktor, best_menge_einh_inhalt, ausg_menge_einh_id, ausg_umrech_faktor, ausg_menge_einh_inhalt) AS SELECT
 V01.mandant_id,
 V01.art_id,
 SUBSTR(CAST(CASE
    WHEN V01.best_menge_einh_id IS NULL OR V01.best_menge_einh_id = ''
    THEN 'ST'
    ELSE V01.best_menge_einh_id
    END AS STRING), 1, 3) AS best_menge_einh_id,
 COALESCE(CASE
   WHEN V02.umrech_faktor = 0
   THEN NULL
   ELSE V02.umrech_faktor
   END, 1) AS best_umrech_faktor,
 ROUND(CAST(TRUNC(CAST(1 / COALESCE(CASE
        WHEN V02.umrech_faktor = 0
        THEN NULL
        ELSE V02.umrech_faktor
        END, 1) AS BIGNUMERIC)) AS NUMERIC), 0) AS best_menge_einh_inhalt,
 SUBSTR(CAST(CASE
    WHEN V03.ausg_menge_einh_id IS NULL OR V03.ausg_menge_einh_id = ''
    THEN 'ST'
    ELSE V03.ausg_menge_einh_id
    END AS STRING), 1, 3) AS ausg_menge_einh_id,
 COALESCE(CASE
   WHEN V04.umrech_faktor = 0
   THEN NULL
   ELSE V04.umrech_faktor
   END, 1) AS ausg_umrech_faktor,
 ROUND(CAST(TRUNC(CAST(1 / COALESCE(CASE
        WHEN V04.umrech_faktor = 0
        THEN NULL
        ELSE V04.umrech_faktor
        END, 1) AS BIGNUMERIC)) AS NUMERIC), 0) AS ausg_menge_einh_inhalt
FROM kfl_production_dbp_view.v_art_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id
     = V02.art_id AND V01.best_menge_einh_id = V02.altnv_menge_einh_id AND V02.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id =
    V03.art_id AND V03.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.art_id
     = V04.art_id AND V03.ausg_menge_einh_id = V04.altnv_menge_einh_id AND V04.dat_bis = DATE '9999-12-31';