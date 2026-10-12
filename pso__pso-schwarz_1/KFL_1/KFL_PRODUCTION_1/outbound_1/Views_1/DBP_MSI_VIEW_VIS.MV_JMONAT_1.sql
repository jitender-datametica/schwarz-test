CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_jmonat_1 (jmo, jmo_bez, jmo_bez_de, jmo_bez_cz, jmo_bez_sk,
jmo_bez_hr, jmo_bez_pl, jmo_bez_ro, jmo_bez_bg, jmo_kbez, jmo_kbez_de, jmo_kbez_cz, jmo_kbez_sk, jmo_kbez_hr,
jmo_kbez_pl, jmo_kbez_ro, jmo_kbez_bg) AS SELECT mo_id AS jmo,
 MAX(CASE
   WHEN spr_id = 22
   THEN mo_bez
   ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
   END) AS jmo_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN mo_bez
   ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
   END) AS jmo_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN CASE
    WHEN spr_id = 124 AND mo_id = 6
    THEN 'Cvn'
    WHEN spr_id = 124 AND mo_id = 7
    THEN 'Cvc'
    ELSE TRIM(SUBSTR(mo_bez, 1, 3))
    END
   ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
   END) AS jmo_kbez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN CASE
    WHEN spr_id = 124 AND mo_id = 6
    THEN 'Cvn'
    WHEN spr_id = 124 AND mo_id = 7
    THEN 'Cvc'
    ELSE TRIM(SUBSTR(mo_bez, 1, 3))
    END
   ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
   END) AS jmo_kbez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_kbez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_kbez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_kbez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_kbez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_kbez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN CASE
     WHEN spr_id = 124 AND mo_id = 6
     THEN 'Cvn'
     WHEN spr_id = 124 AND mo_id = 7
     THEN 'Cvc'
     ELSE TRIM(SUBSTR(mo_bez, 1, 3))
     END
    ELSE TRIM(SUBSTR(CAST(mo_id AS STRING), 1, 39))
    END)) AS jmo_kbez_bg
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS MSZ
GROUP BY jmo;