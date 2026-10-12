CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_transp_auftrag_lagereinheit (mandant_id, wup_id, nb_id, art_id,
lagerort_id, lagernummer_id_ta1, nach_lagertyp_id_ta1, nach_lagerplatz_id_ta1, dat_erstellung, entn_quittierdatum_einl,
entn_quittierzeit_einl, quittierdatum_we, quittierzeit_we, quittierung_we, lagernummer_id_ta2, nach_lagertyp_id_ta2,
nach_lagerplatz_id_ta2, quittierdatum_einlagerung, quittierzeit_einlagerung, quittierung_einlagerung, lenr, standzeit_we
, standzeit_we_tor, standzeit_we_palette, ta2_null_flg, global_nach_lagertyp_id_ta2) AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 lagerort_id,
 lagernummer_id_ta1,
 lagertyp_id_ta1 AS nach_lagertyp_id_ta1,
 lagerplatz_id_ta1 AS nach_lagerplatz_id_ta1,
 dat_erstellung,
 DATE(datzeit_entn_quittierung_einl) AS entn_quittierdatum_einl,
 CAST(datzeit_entn_quittierung_einl AS TIME) AS entn_quittierzeit_einl,
 DATE(datzeit_quittierung_we) AS quittierdatum_we,
 CAST(datzeit_quittierung_we AS TIME) AS quittierzeit_we,
 datzeit_quittierung_we AS quittierung_we,
 lagernummer_id_ta2,
 lagertyp_id_ta2 AS nach_lagertyp_id_ta2,
 lagerplatz_id_ta2 AS nach_lagerplatz_id_ta2,
 DATE(datzeit_quittierung_einl) AS quittierdatum_einlagerung,
 CAST(datzeit_quittierung_einl AS TIME) AS quittierzeit_einlagerung,
 datzeit_quittierung_einl AS quittierung_einlagerung,
 lager_einheit_id AS lenr,
 CAST(CASE
   WHEN datzeit_quittierung_einl IS NOT NULL
   THEN CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, datzeit_quittierung_we, SECOND)) ,'$.DAY')AS INT64)  * 86400 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, datzeit_quittierung_we, SECOND)) ,'$.HOUR')AS INT64)  * 3600 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl
        ,datzeit_quittierung_we, SECOND)) ,'$.MINUTE')AS INT64)  * 60 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, datzeit_quittierung_we, SECOND)) ,'$.SECOND')AS INT64)
   ELSE NULL
   END AS BIGNUMERIC) AS standzeit_we,
 CAST(CASE
   WHEN datzeit_quittierung_einl IS NOT NULL
   THEN CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(CAST(datzeit_entn_quittierung_einl AS DATETIME),
         datzeit_quittierung_we, SECOND)) ,'$.DAY')AS INT64)  * 86400 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(CAST(datzeit_entn_quittierung_einl AS DATETIME)
         ,datzeit_quittierung_we, SECOND)) ,'$.HOUR')AS INT64)  * 3600 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(CAST(datzeit_entn_quittierung_einl AS DATETIME)
        ,datzeit_quittierung_we, SECOND)) ,'$.MINUTE')AS INT64)  * 60 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(CAST(datzeit_entn_quittierung_einl AS DATETIME)
      ,datzeit_quittierung_we, SECOND)) ,'$.SECOND')AS INT64)
   ELSE NULL
   END AS BIGNUMERIC) AS standzeit_we_tor,
 CAST(CASE
   WHEN datzeit_quittierung_einl IS NOT NULL
   THEN CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, CAST(datzeit_entn_quittierung_einl AS DATETIME)
         ,SECOND)) ,'$.DAY')AS INT64)  * 86400 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, CAST(datzeit_entn_quittierung_einl AS DATETIME)
         ,SECOND)) ,'$.HOUR')AS INT64)  * 3600 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, CAST(datzeit_entn_quittierung_einl AS DATETIME)
        ,SECOND)) ,'$.MINUTE')AS INT64)  * 60 + CAST(JSON_EXTRACT_SCALAR(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(datzeit_quittierung_einl, CAST(datzeit_entn_quittierung_einl AS DATETIME)
      ,SECOND)) ,'$.SECOND')AS INT64)
   ELSE NULL
   END AS BIGNUMERIC) AS standzeit_we_palette,
  CASE
  WHEN lagernummer_id_ta2 IS NULL
  THEN 1
  ELSE 0
  END AS ta2_null_flg,
  CASE
  WHEN SUBSTR(lagertyp_id_ta2, 1, 2) = 'R0'
  THEN 'Regal Erdgeschoss'
  WHEN SUBSTR(lagertyp_id_ta2, 1, 2) = 'R1'
  THEN 'Regal Obergeschoss'
  WHEN SUBSTR(lagertyp_id_ta2, 1, 1) = 'G'
  THEN 'Griffzone'
  ELSE 'Sonstige'
  END AS global_nach_lagertyp_id_ta2
FROM kfl_production_dbp_view.v_standzeiten_we AS V01;