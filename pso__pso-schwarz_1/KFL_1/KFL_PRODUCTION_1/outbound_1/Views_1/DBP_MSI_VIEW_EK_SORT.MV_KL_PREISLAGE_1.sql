CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_kl_preislage_1 (mandant_id, matching_id, sm_id, ksm_id,
owg_id, wg_id, wug_id, vk_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge,
menge_af, menge_sa, kjmo, kjwo_update, wrg_id, preisstufe, wert_preisstufe, preisstufe_vk_pk, wert_preisstufe_vk_pk,
cntprod) AS SELECT V01.mandant_id,
 V01.art_matching_id AS matching_id,
 V01.sm_id,
 V01.ksm_id,
 V01.owg_id,
 V01.wg_id,
 V01.wug_id,
 V01.vk_brutto_pk_1 AS vk_pk_1,
 V01.durchschnitt_preis_kasse,
 V01.umsatz_brutto,
 V01.umsatz_brutto_af,
 V01.umsatz_brutto_sa,
 V01.menge,
 V01.menge_af,
 V01.menge_sa,
 V01.kjmo,
 V01.kjwo_update,
 V01.wrg_id,
  CASE
  WHEN V01.durchschnitt_preis_kasse < V02.preislage_1 OR V01.durchschnitt_preis_kasse IS NULL
  THEN 1
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_1 AND V01.durchschnitt_preis_kasse < V02.preislage_2
  THEN 2
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_2 AND V01.durchschnitt_preis_kasse < V02.preislage_3
  THEN 3
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_3 AND V01.durchschnitt_preis_kasse < V02.preislage_4
  THEN 4
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_4 AND V01.durchschnitt_preis_kasse < V02.preislage_5
  THEN 5
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_5 AND V01.durchschnitt_preis_kasse < V02.preislage_6
  THEN 6
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_6 AND V01.durchschnitt_preis_kasse < V02.preislage_7
  THEN 7
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_7 AND V01.durchschnitt_preis_kasse < V02.preislage_8
  THEN 8
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_8 AND V01.durchschnitt_preis_kasse < V02.preislage_9
  THEN 9
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_9
  THEN 10
  ELSE NULL
  END AS preisstufe,
  CASE
  WHEN V01.durchschnitt_preis_kasse < V02.preislage_1 OR V01.durchschnitt_preis_kasse IS NULL
  THEN '< ' || TRIM(SUBSTR(CAST(V02.preislage_1 AS STRING), 1, 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_1 AND V01.durchschnitt_preis_kasse < V02.preislage_2
  THEN TRIM(SUBSTR(CAST(V02.preislage_1 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_2 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_2 AND V01.durchschnitt_preis_kasse < V02.preislage_3
  THEN TRIM(SUBSTR(CAST(V02.preislage_2 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_3 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_3 AND V01.durchschnitt_preis_kasse < V02.preislage_4
  THEN TRIM(SUBSTR(CAST(V02.preislage_3 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_4 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_4 AND V01.durchschnitt_preis_kasse < V02.preislage_5
  THEN TRIM(SUBSTR(CAST(V02.preislage_4 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_5 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_5 AND V01.durchschnitt_preis_kasse < V02.preislage_6
  THEN TRIM(SUBSTR(CAST(V02.preislage_5 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_6 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_6 AND V01.durchschnitt_preis_kasse < V02.preislage_7
  THEN TRIM(SUBSTR(CAST(V02.preislage_6 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_7 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_7 AND V01.durchschnitt_preis_kasse < V02.preislage_8
  THEN TRIM(SUBSTR(CAST(V02.preislage_7 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_8 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_8 AND V01.durchschnitt_preis_kasse < V02.preislage_9
  THEN TRIM(SUBSTR(CAST(V02.preislage_8 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_9 AS STRING), 1
     , 10))
  WHEN V01.durchschnitt_preis_kasse >= V02.preislage_9
  THEN '> ' || TRIM(SUBSTR(CAST(V02.preislage_9 AS STRING), 1, 10))
  ELSE NULL
  END AS wert_preisstufe,
  CASE
  WHEN V01.vk_brutto_pk_1 < V02.preislage_1 OR V01.vk_brutto_pk_1 IS NULL
  THEN 1
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_1 AND V01.vk_brutto_pk_1 < V02.preislage_2
  THEN 2
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_2 AND V01.vk_brutto_pk_1 < V02.preislage_3
  THEN 3
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_3 AND V01.vk_brutto_pk_1 < V02.preislage_4
  THEN 4
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_4 AND V01.vk_brutto_pk_1 < V02.preislage_5
  THEN 5
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_5 AND V01.vk_brutto_pk_1 < V02.preislage_6
  THEN 6
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_6 AND V01.vk_brutto_pk_1 < V02.preislage_7
  THEN 7
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_7 AND V01.vk_brutto_pk_1 < V02.preislage_8
  THEN 8
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_8 AND V01.vk_brutto_pk_1 < V02.preislage_9
  THEN 9
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_9
  THEN 10
  ELSE NULL
  END AS preisstufe_vk_pk,
  CASE
  WHEN V01.vk_brutto_pk_1 < V02.preislage_1 OR V01.vk_brutto_pk_1 IS NULL
  THEN '< ' || TRIM(SUBSTR(CAST(V02.preislage_1 AS STRING), 1, 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_1 AND V01.vk_brutto_pk_1 < V02.preislage_2
  THEN TRIM(SUBSTR(CAST(V02.preislage_1 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_2 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_2 AND V01.vk_brutto_pk_1 < V02.preislage_3
  THEN TRIM(SUBSTR(CAST(V02.preislage_2 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_3 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_3 AND V01.vk_brutto_pk_1 < V02.preislage_4
  THEN TRIM(SUBSTR(CAST(V02.preislage_3 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_4 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_4 AND V01.vk_brutto_pk_1 < V02.preislage_5
  THEN TRIM(SUBSTR(CAST(V02.preislage_4 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_5 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_5 AND V01.vk_brutto_pk_1 < V02.preislage_6
  THEN TRIM(SUBSTR(CAST(V02.preislage_5 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_6 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_6 AND V01.vk_brutto_pk_1 < V02.preislage_7
  THEN TRIM(SUBSTR(CAST(V02.preislage_6 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_7 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_7 AND V01.vk_brutto_pk_1 < V02.preislage_8
  THEN TRIM(SUBSTR(CAST(V02.preislage_7 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_8 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_8 AND V01.vk_brutto_pk_1 < V02.preislage_9
  THEN TRIM(SUBSTR(CAST(V02.preislage_8 AS STRING), 1, 10)) || ' - < ' || TRIM(SUBSTR(CAST(V02.preislage_9 AS STRING), 1
     , 10))
  WHEN V01.vk_brutto_pk_1 >= V02.preislage_9
  THEN '> ' || TRIM(SUBSTR(CAST(V02.preislage_9 AS STRING), 1, 10))
  ELSE NULL
  END AS wert_preisstufe_vk_pk,
 1 AS cntprod
FROM kfl_production_dbp_view.v_art_kl_preislage_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_ts_sortiment_preisklasse_wug_1 AS V02 ON V01.wg_id = V02.wg_id AND V01.wug_id = V02
     .wug_id AND V01.mandant_id = V02.mandant_id AND V01.wrg_id = V02.wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.wrg_id = V03.default_wrg;