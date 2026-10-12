CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerort_spr_zu (mandant_id, wup_id, nb_id, lagerort_id,
lagerort_bez, lagerort_bez_de, lagerort_bez_cz, lagerort_bez_sk, lagerort_bez_hr, lagerort_bez_pl, lagerort_bez_ro,
lagerort_bez_bg, lagerort_bez_short, lagerort_bez_short_cz, lagerort_bez_short_sk, lagerort_bez_short_hr,
lagerort_bez_short_pl, lagerort_bez_short_ro, lagerort_bez_short_bg, lagerort_bez_sap, lagerort_bez_sap_cz,
lagerort_bez_sap_sk, lagerort_bez_sap_hr, lagerort_bez_sap_pl, lagerort_bez_sap_ro, lagerort_bez_sap_bg,
lagerort_bez_altn, lagerort_bez_altn_cz, lagerort_bez_altn_sk, lagerort_bez_altn_hr, lagerort_bez_altn_pl,
lagerort_bez_altn_ro, lagerort_bez_altn_bg) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez,
 TRIM(MAX(CASE
    WHEN V01.spr_id = 22
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END)) AS lagerort_bez_de,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
      WHEN V01.spr_id = 124
      THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
      ELSE NULL
      END), TRIM(MAX(CASE
       WHEN V01.spr_id = 22
       THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
       ELSE NULL
       END)))) AS lagerort_bez_cz,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
      WHEN V01.spr_id = 108
      THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
      ELSE NULL
      END), TRIM(MAX(CASE
       WHEN V01.spr_id = 22
       THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
       ELSE NULL
       END)))) AS lagerort_bez_sk,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
      WHEN V01.spr_id = 65
      THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
      ELSE NULL
      END), TRIM(MAX(CASE
       WHEN V01.spr_id = 22
       THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
       ELSE NULL
       END)))) AS lagerort_bez_hr,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
      WHEN V01.spr_id = 90
      THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
      ELSE NULL
      END), TRIM(MAX(CASE
       WHEN V01.spr_id = 22
       THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
       ELSE NULL
       END)))) AS lagerort_bez_pl,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
      WHEN V01.spr_id = 95
      THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
      ELSE NULL
      END), TRIM(MAX(CASE
       WHEN V01.spr_id = 22
       THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
       ELSE NULL
       END)))) AS lagerort_bez_ro,
 TRIM(CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
      WHEN V01.spr_id = 18
      THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
      ELSE NULL
      END), TRIM(MAX(CASE
       WHEN V01.spr_id = 22
       THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
       ELSE NULL
       END)))) AS lagerort_bez_bg,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
   ELSE NULL
   END) AS lagerort_bez_short,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END), TRIM(MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END))) AS lagerort_bez_short_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END), TRIM(MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END))) AS lagerort_bez_short_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END), TRIM(MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END))) AS lagerort_bez_short_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END), TRIM(MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END))) AS lagerort_bez_short_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END), TRIM(MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END))) AS lagerort_bez_short_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END), TRIM(MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END))) AS lagerort_bez_short_bg,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap,
 MAX(CASE
   WHEN V01.spr_id = 124
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap_cz,
 MAX(CASE
   WHEN V01.spr_id = 108
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap_sk,
 MAX(CASE
   WHEN V01.spr_id = 65
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap_hr,
 MAX(CASE
   WHEN V01.spr_id = 90
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap_pl,
 MAX(CASE
   WHEN V01.spr_id = 95
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap_ro,
 MAX(CASE
   WHEN V01.spr_id = 95
   THEN V01.lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_sap_bg,
 MAX(CASE
   WHEN V01.spr_id = 22 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn,
 MAX(CASE
   WHEN V01.spr_id = 124 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn_cz,
 MAX(CASE
   WHEN V01.spr_id = 108 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn_sk,
 MAX(CASE
   WHEN V01.spr_id = 65 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn_hr,
 MAX(CASE
   WHEN V01.spr_id = 90 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn_pl,
 MAX(CASE
   WHEN V01.spr_id = 95 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn_ro,
 MAX(CASE
   WHEN V01.spr_id = 95 AND LENGTH(TRIM(V02.lagerort_bez)) = 0
   THEN '_BLANK'
   ELSE V02.lagerort_bez
   END) AS lagerort_bez_altn_bg
FROM kfl_production_dbp_view.v_lagerort_spr_zu AS V01
 LEFT JOIN kfl_production_dbp_msi_view_log.ts_lagerort_altn_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id
      = V02.wup_id AND V01.lagerort_id = V02.lagerort_id AND V01.spr_id = V02.spr_id
WHERE V01.lagerort_id NOT IN ('-2', '-3')
GROUP BY V01.mandant_id,
 V01.lagerort_id,
 V01.nb_id,
 V01.wup_id;