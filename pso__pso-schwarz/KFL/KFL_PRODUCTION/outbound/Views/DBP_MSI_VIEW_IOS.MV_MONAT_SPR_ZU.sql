CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_monat_spr_zu (mo_gj, mo_kj, mo_bez, mo_bez_cz, mo_bez_sk,
mo_bez_hr, mo_bez_pl, mo_bez_ro, mo_bez_en, mo_bez_bg, kjmo, kj, gj, gjmo, mo_bez_lang, mo_bez_lang_cz, mo_bez_lang_sk,
mo_bez_lang_hr, mo_bez_lang_pl, mo_bez_lang_ro, mo_bez_lang_en, mo_bez_lang_bg, v_mo_bez_lang, v_mo_bez_lang_cz,
v_mo_bez_lang_sk, v_mo_bez_lang_hr, v_mo_bez_lang_pl, v_mo_bez_lang_ro, v_mo_bez_lang_en, v_mo_bez_lang_bg) AS SELECT M
 .mo_gj,
 S.mo_id AS mo_kj,
 MAX(CASE
   WHEN S.spr_id = 22
   THEN S.mo_bez
   ELSE NULL
   END) AS mo_bez,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 124
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_cz,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 108
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_sk,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 65
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_hr,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 90
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_pl,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 95
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_ro,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 24
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_en,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 18
    THEN S.mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN S.mo_bez
    ELSE NULL
    END)) AS mo_bez_bg,
 M.kjmo,
 M.kj,
 M.gj,
 M.gjmo,
 MAX(CASE
   WHEN S.spr_id = 22
   THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
   ELSE NULL
   END) AS mo_bez_lang,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 124
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 108
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 65
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 90
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 95
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 24
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_en,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 18
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39))
    ELSE NULL
    END)) AS mo_bez_lang_bg,
 MAX(CASE
   WHEN S.spr_id = 22
   THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
        WHEN S.mo_id = 1
        THEN M.kj - 1
        ELSE M.kj
        END AS STRING), 1, 39))
   ELSE NULL
   END) AS v_mo_bez_lang,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 124
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 108
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 65
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 90
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 95
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 24
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_en,
 COALESCE(MAX(CASE
    WHEN S.spr_id = 18
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END), MAX(CASE
    WHEN S.spr_id = 22
    THEN TRIM(S2.mo_bez) || ' ' || TRIM(SUBSTR(CAST(CASE
         WHEN S.mo_id = 1
         THEN M.kj - 1
         ELSE M.kj
         END AS STRING), 1, 39))
    ELSE NULL
    END)) AS v_mo_bez_lang_bg
FROM kfl_production_dbp_view.v_monat_spr_zu AS S
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu AS S2 ON CASE
    WHEN S.mo_id = 1
    THEN 12
    ELSE S.mo_id - 1
    END = S2.mo_id AND S.spr_id = S2.spr_id
 INNER JOIN kfl_production_dbp_view.v_monat AS M ON S.mo_id = M.mo_kj
GROUP BY M.mo_gj,
 S.mo_id,
 M.kjmo,
 M.kj,
 M.gj,
 M.gjmo;