/* #DescStart#
#DescEnd# */ CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_store_to_wh_delivery_hist AS
-- ungelöschte (aktive) Zuordnungssätze sind die Auswahlbasis für eine LAST-KNOWN-Darstellung.

-- Zusätzlich gab es in der alten ORG_STORE_SKEY-Darstellung aus dem ELWIS-COEX-LAYER eine Filterung auf diejenigen Stores,

-- welche auch einen direkten WAWI-NaturalKey aufwiesen. Reine SAP-Lokations wurden also nicht dargestellt.

-- Da auch bereits zukünftig aktive Sätze in der Core-Tabelle geführt werden, sind diese bei LAST-KNOWN auszublenden.

-- Um die Menge zur alten Darstellung komplett identisch halten zu können, wird hier die eigentlich nicht mehr zu vertretende Einschränkung vorgenommen

-- und ein Flag zur Ermittlung der alten SKEY-Last-Known-Darstellung gebildet.

-- Normalerweise braucht lediglich das Deleted-Flag herangezogen werden, um den letzten aktiven Satz via Row-Number() zu markieren.

-- Es kann im untigen Nummerierungs- bzw. Markierungsausdruck bei Obsoletwerden des aus COEX nachgebauten Kombatibilitätsmarts durch das DELETED_FG ersetzt werden.

-- Via Row_Number() werden die Einzelsätze nummeriert pro Gruppe ([valide Sätze] und [LOCATION]) absteigend nach dem Gültigkeitsstartdatum.

-- Der jeweils jüngste Satz der Gruppe bekommt also die Nummer 1.

-- Anhängen der "echten" Stores - ergo keiner Warehouses
 SELECT s2w_final.client_id,
 s2w_final.loc_sid_store,
 s2w_final.mult_wh_err_fg,
 s2w_final.wh_with_itemgrp_err_fg,
 s2w_final.source_raw_info,
 s2w_final.loc_sid_wh_list,
 s2w_final.priority_list,
 s2w_final.loc_sid_wh_01,
 s2w_final.priority_01,
 s2w_final.loc_sid_wh_02,
 s2w_final.priority_02,
 s2w_final.loc_sid_wh_03,
 s2w_final.priority_03,
 s2w_final.loc_sid_wh_04,
 s2w_final.priority_04,
 s2w_final.loc_sid_wh_05,
 s2w_final.priority_05,
 s2w_final.loc_sid_wh_06,
 s2w_final.priority_06,
 s2w_final.loc_sid_wh_07,
 s2w_final.priority_07,
 s2w_final.loc_sid_wh_08,
 s2w_final.priority_08,
 s2w_final.loc_sid_wh_09,
 s2w_final.priority_09,
 s2w_final.loc_sid_wh_10,
 s2w_final.priority_10,
 s2w_final.deleted_fg,
 s2w_final.dwh_valid_from,
 s2w_final.dwh_valid_to,
 s2w_final.dwh_actual_fg,
  CASE
  WHEN s2w_final.deleted_fg = 0 AND s2w_final.dwh_valid_from <= CURRENT_DATE AND COALESCE(store.src_orig_store_nr, 0) <>
    0
  THEN 0
  ELSE 1
  END AS lastknown_fadeout_fg,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CASE
         WHEN s2w_final.deleted_fg = 0 AND s2w_final.dwh_valid_from <= CURRENT_DATE AND COALESCE(store.src_orig_store_nr
            , 0) <> 0
         THEN 0
         ELSE 1
         END, CAST(s2w_final.client_id AS STRING), CAST(s2w_final.loc_sid_store AS STRING) ORDER BY s2w_final.dwh_valid_from
        IS NULL DESC, s2w_final.dwh_valid_from DESC)) = 1 AND CASE
     WHEN s2w_final.deleted_fg = 0 AND s2w_final.dwh_valid_from <= CURRENT_DATE AND COALESCE(store.src_orig_store_nr, 0
        ) <> 0
     THEN 0
     ELSE 1
     END = 0
  THEN 1
  ELSE 0
  END AS lastknown_fg
FROM (SELECT client_id,
   loc_sid_store,
    CASE
    WHEN cnt_wh_same_prio > 1
    THEN 1
    ELSE 0
    END AS mult_wh_err_fg,
    CASE
    WHEN cnt_igrp > 0
    THEN 1
    ELSE 0
    END AS wh_with_itemgrp_err_fg,
   NULLIF(loc_sid_wh_rawinfo_list, '') AS source_raw_info,
   NULLIF(loc_sid_wh_list, '') AS loc_sid_wh_list,
   NULLIF(priority_list, '') AS priority_list,
   IF(ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0) = 0, NULL, ROUND(CAST(REGEXP_EXTRACT_ALL(','
        || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0)) AS loc_sid_wh_01,
   NULLIF(ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(0)] AS BIGNUMERIC), 0), 0) AS
   priority_01,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(1)] AS BIGNUMERIC), 0) AS loc_sid_wh_02,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(1)] AS BIGNUMERIC), 0) AS priority_02,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(2)] AS BIGNUMERIC), 0) AS loc_sid_wh_03,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(2)] AS BIGNUMERIC), 0) AS priority_03,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(3)] AS BIGNUMERIC), 0) AS loc_sid_wh_04,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(3)] AS BIGNUMERIC), 0) AS priority_04,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(4)] AS BIGNUMERIC), 0) AS loc_sid_wh_05,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(4)] AS BIGNUMERIC), 0) AS priority_05,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(5)] AS BIGNUMERIC), 0) AS loc_sid_wh_06,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(5)] AS BIGNUMERIC), 0) AS priority_06,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(6)] AS BIGNUMERIC), 0) AS loc_sid_wh_07,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(6)] AS BIGNUMERIC), 0) AS priority_07,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(7)] AS BIGNUMERIC), 0) AS loc_sid_wh_08,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(7)] AS BIGNUMERIC), 0) AS priority_08,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(8)] AS BIGNUMERIC), 0) AS loc_sid_wh_09,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(8)] AS BIGNUMERIC), 0) AS priority_09,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || loc_sid_wh_list, '[^,]+')[SAFE_OFFSET(9)] AS BIGNUMERIC), 0) AS loc_sid_wh_10,
   ROUND(CAST(REGEXP_EXTRACT_ALL(',' || priority_list, '[^,]+')[SAFE_OFFSET(9)] AS BIGNUMERIC), 0) AS priority_10,
   deleted_fg,
   dwh_valid_from,
   COALESCE(DATE_SUB(MIN(dwh_valid_from) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING)
      ORDER BY dwh_valid_from IS NULL, dwh_valid_from ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY),
    PARSE_DATE('%d.%m.%Y', '30.12.9999')) AS dwh_valid_to,
    CASE
    WHEN CURRENT_DATE BETWEEN dwh_valid_from AND (COALESCE(DATE_SUB(MIN(dwh_valid_from) OVER (PARTITION BY CAST(client_id AS STRING)
           , CAST(loc_sid_store AS STRING) ORDER BY dwh_valid_from IS NULL, dwh_valid_from ROWS BETWEEN 1 FOLLOWING AND
         1 FOLLOWING), INTERVAL 1 DAY), PARSE_DATE('%d.%m.%Y', '30.12.9999')))
    THEN 1
    ELSE 0
    END AS dwh_actual_fg
  FROM (SELECT client_id,
      loc_sid_store,
      cnt_wh_same_prio,
      cnt_igrp,
      max_item_grp_cd,
      loc_sid_wh_rawinfo_list,
      loc_sid_wh_list,
      priority_list,
      deleted_fg,
      dwh_valid_from
     FROM ldl_p_lew_bil.v_mat0_store_to_wh_delivery_hist
     EXCEPT DISTINCT
     SELECT client_id,
      loc_sid_store,
      cnt_wh_same_prio,
      cnt_igrp,
      max_item_grp_cd,
      loc_sid_wh_rawinfo_list,
      loc_sid_wh_list,
      priority_list,
      deleted_fg,
      DATE_ADD(dwh_valid_to, INTERVAL 1 DAY)
     FROM ldl_p_lew_bil.v_mat0_store_to_wh_delivery_hist) AS t1
  QUALIFY DATE_DIFF(COALESCE(DATE_SUB(MIN(dwh_valid_from) OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING)
           ORDER BY dwh_valid_from IS NULL, dwh_valid_from ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY),
       PARSE_DATE('%d.%m.%Y', '30.12.9999')), dwh_valid_from, DAY) <> 2958462 OR deleted_fg <> 1) AS s2w_final
 LEFT JOIN (SELECT *
  FROM ldl_p_lew_core_ac.v_location
  WHERE UPPER(wh_store_mark) = 'A') AS store ON s2w_final.client_id = store.client_id AND s2w_final.loc_sid_store =
   store.loc_sid;