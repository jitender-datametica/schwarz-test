
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lagerbestand_lvs_belegung_2 (mandant_id, lagerplatz_id,
lagernummer_id, lagertyp_id, art_id, dat, volumen_kolli, volumen_palette, volumen_belegt, bestandsmenge_in_paletten) AS
SELECT mandant_id,
 lagerplatz_id,
 lagernummer_id,
 lagertyp_id,
 art_id,
 dat,
 MAX(volumen_kolli) AS volumen_kolli,
 MAX(volumen_palette) AS volumen_palette,
  CASE
  WHEN lagertyp_id IN ('TR1', 'RL1', '916') OR SUBSTR(lagertyp_id, 1, 1) = 'G'
  THEN CAST(MAX(volumen_kolli) AS FLOAT64)
  ELSE MAX(volumen_palette)
  END AS volumen_belegt,
 MAX(bestandsmenge_in_paletten) AS bestandsmenge_in_paletten
FROM (SELECT T1.mandant_id,
   T1.lagerplatz_id,
   T1.lagernummer_id,
   T1.lagertyp_id,
   T1.art_id,
   T1.dat,
   MAX(CASE
     WHEN t2.zl_kolli_menge_einh_id = T3.altnv_menge_einh_id
     THEN T3.laenge * T3.breite * T3.hoehe
     ELSE NULL
     END) OVER (PARTITION BY CAST(T1.mandant_id AS STRING), T1.dat, CAST(T1.art_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS volumen_kolli,
    CASE
    WHEN t2.paletten_faktor_einh_id = T3.altnv_menge_einh_id
    THEN CASE
     WHEN T3.laenge IN (0, NULL) OR T3.breite IN (0, NULL) OR T3.hoehe IN (0, NULL)
     THEN CASE
      WHEN UDF_SCHEMA.IS_INTEGER_UDF(TO_JSON(t2.paletten_faktor_einh_id))
      THEN CAST(t2.paletten_faktor_einh_id_num AS FLOAT64) / CAST(t2.zl_kolli_menge_einh_id_num AS FLOAT64) * T1.volumen_kolli
       
      ELSE 1 / CAST(T3.umrech_faktor AS BIGNUMERIC) / CAST(t2.zl_kolli_menge_einh_id_num AS FLOAT64) * T1.volumen_kolli
      END
     ELSE CAST(T3.laenge * T3.breite * T3.hoehe AS FLOAT64)
     END
    ELSE NULL
    END AS volumen_palette,
    CASE
    WHEN T1.lagertyp_id = 'TR1' OR SUBSTR(T1.lagertyp_id, 1, 1) = 'G'
    THEN T1.menge_lgbest_lvs_palette
    ELSE 1
    END AS bestandsmenge_in_paletten
  FROM kfl_production_dbp_view.v_lagerbestand_lvs_2 AS T1_2
   LEFT JOIN (SELECT mandant_id,
     art_id,
     dat_von,
     ausg_menge_einh_id,
     paletten_faktor_einh_id,
     dat_bis,
     sortimentslistenart_id,
     zl_kolli_menge_einh_id,
     lage_faktor_einh_id,
     auspack_fg,
      CASE
      WHEN UDF_SCHEMA.IS_INTEGER_UDF(TO_JSON(zl_kolli_menge_einh_id))
      THEN zl_kolli_menge_einh_id
      ELSE NULL
      END AS zl_kolli_menge_einh_id_num,
      CASE
      WHEN UDF_SCHEMA.IS_INTEGER_UDF(TO_JSON(paletten_faktor_einh_id))
      THEN paletten_faktor_einh_id
      ELSE NULL
      END AS paletten_faktor_einh_id_num
    FROM kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS A1) AS t2 ON T1.mandant_id = t2.mandant_id AND T1.art_id =
      t2.art_id AND T1.dat BETWEEN t2.dat_von AND t2.dat_bis
   LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_2 AS T3 ON T1.mandant_id = T3.mandant_id AND T1.art_id =
      T3.art_id AND T1.dat BETWEEN T3.dat_von AND T3.dat_bis) AS dt1
GROUP BY mandant_id,
 lagerplatz_id,
 lagernummer_id,
 lagertyp_id,
 art_id,
 dat;


