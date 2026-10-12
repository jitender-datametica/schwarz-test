
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_itm_orig_item_desc_2
OPTIONS(DESCRIPTION='ORIGINAL ITEM_2 DESCRIPTION VIEW', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true)
AS
SELECT t8.client_id0 AS client_id,
 t8.orig_item_nr,
 t8.dat_valid_from,
 MAX(CASE
   WHEN t8.lang_client = 1
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_at,
 MAX(CASE
   WHEN t8.lang_client = 2
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_be,
 MAX(CASE
   WHEN t8.lang_client = 3
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_bg,
 MAX(CASE
   WHEN t8.lang_client = 4
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_ch,
 MAX(CASE
   WHEN t8.lang_client = 5
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_cy,
 MAX(CASE
   WHEN t8.lang_client = 6
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_cz,
 MAX(CASE
   WHEN t8.lang_cd = '@'
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc,
 MAX(CASE
   WHEN t8.lang_client = 8
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_dk,
 MAX(CASE
   WHEN t8.lang_client = 9
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_ee,
 MAX(CASE
   WHEN t8.lang_client IN (10, 31)
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_es,
 MAX(CASE
   WHEN t8.lang_client = 11
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_fi,
 MAX(CASE
   WHEN t8.lang_client = 12
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_fr,
 MAX(CASE
   WHEN t8.lang_client = 13
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_gb,
 MAX(CASE
   WHEN t8.lang_client = 14
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_gr,
 MAX(CASE
   WHEN t8.lang_client = 15
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_hr,
 MAX(CASE
   WHEN t8.lang_client = 16
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_hu,
 MAX(CASE
   WHEN t8.lang_client IN (17, 21)
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_ie,
 MAX(CASE
   WHEN t8.lang_client IN (18, 32)
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_it,
 MAX(CASE
   WHEN t8.lang_client = 19
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_lt,
 MAX(CASE
   WHEN t8.lang_client = 20
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_lv,
 MAX(CASE
   WHEN t8.lang_client = 21
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_ni,
 MAX(CASE
   WHEN t8.lang_client = 22
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_nl,
 MAX(CASE
   WHEN t8.lang_client = 23
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_de,
 MAX(CASE
   WHEN t8.lang_client = 24
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_pl,
 MAX(CASE
   WHEN t8.lang_client = 25
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_pt,
 MAX(CASE
   WHEN t8.lang_client = 26
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_ro,
 MAX(CASE
   WHEN t8.lang_client = 27
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_se,
 MAX(CASE
   WHEN t8.lang_client = 28
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_si,
 MAX(CASE
   WHEN t8.lang_client = 29
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_sk,
 MAX(CASE
   WHEN t8.lang_client = 31
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_cs,
 MAX(CASE
   WHEN t8.lang_client = 32
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_mt,
 MAX(CASE
   WHEN t8.lang_client = 33
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_us,
 MAX(CASE
   WHEN t8.lang_client = 34
   THEN t8.item_desc
   ELSE NULL
   END) AS item_desc_rs
FROM (SELECT A.client_id AS client_id0,
   COALESCE(A.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, DATE '9999-12-31') AS dat_valid_from
   ,
   COALESCE(D.item_descr, B0.item_descr) AS item_desc,
   ROUND(CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
   CL.lang_cd,
    CASE
    WHEN CL.lang_cd = '@'
    THEN 0
    ELSE CLI.client_id
    END AS lang_client,
    CASE
    WHEN COALESCE(D.lang_cd, '') = CL.lang_cd AND COALESCE(B0.lang_cd, '') = CL.lang_cd
    THEN 1
    WHEN COALESCE(D.lang_cd, '') = CL.lang_cd AND COALESCE(B0.lang_cd, '') <> CL.lang_cd
    THEN 2
    WHEN COALESCE(D.lang_cd, '') <> CL.lang_cd AND COALESCE(B0.lang_cd, '') = CL.lang_cd
    THEN 3
    ELSE 99
    END AS lng_prio,
   A.client_id
  FROM ldl_p_lew_core_ac.v_item_2 AS A
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLI ON A.client_id = CLI.client_id
   INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CL ON CLI.country_sid = CL.country_sid OR CL.src_country_lidl_cd =
     'INTEGER '
   LEFT JOIN (SELECT A0.client_id,
     A0.item_sid,
     B.src_dat_valid_from
    FROM ldl_p_lew_core_ac.v_item_2 AS A0
     INNER JOIN ldl_p_lew_core_ac.v_item_2 AS B ON A0.client_id = B.client_id AND B.item_sid_config = COALESCE(A0.item_sid_config
         , A0.item_sid) AND B.src_dat_valid_from IS NOT NULL
    WHERE NOT EXISTS (SELECT 1
      FROM ldl_p_lew_core_ac.v_item_2 AS C
      WHERE client_id = A0.client_id
       AND item_sid_config = COALESCE(A0.item_sid_config, A0.item_sid)
       AND (src_dat_valid_from > A0.src_dat_valid_from OR src_dat_valid_from = A0.src_dat_valid_from AND item_sid > A0.item_sid
            ))) AS dwf1 ON A.client_id = dwf1.client_id AND A.item_sid = dwf1.item_sid
   LEFT JOIN (SELECT client_id,
     ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
     MAX(src_dat_valid_from) AS src_dat_valid_from
    FROM ldl_p_lew_core_ac.v_item_2 AS C
    WHERE src_dat_valid_from IS NOT NULL
     AND CAST(src_case_size AS FLOAT64) >= 0
    GROUP BY client_id,
     origi) AS dwf2 ON A.client_id = dwf2.client_id AND dwf2.origi = ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd
         , A.src_matnr) AS BIGNUMERIC), 0) AND A.log_var_cd IS NOT NULL
   LEFT JOIN ldl_p_lew_core_ac.v_item_descr_2 AS B0 ON A.client_id = B0.client_id AND A.item_sid = B0.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_item_2 AS C1 ON A.client_id = C1.client_id AND A.config_item_cd = C1.src_matnr
   LEFT JOIN ldl_p_lew_core_ac.v_item_descr_2 AS D ON C1.client_id = D.client_id AND C1.item_sid = D.item_sid
  WHERE ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) IS NOT NULL
  QUALIFY (MIN(lng_prio) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(orig_item_nr AS STRING), dat_valid_from
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = lng_prio) AS t8
GROUP BY client_id,
 t8.orig_item_nr,
 t8.dat_valid_from;
