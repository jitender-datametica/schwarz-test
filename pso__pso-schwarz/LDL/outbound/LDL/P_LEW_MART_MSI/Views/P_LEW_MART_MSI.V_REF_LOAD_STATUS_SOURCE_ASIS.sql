CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_load_status_source_asis (source_id, source_desc_at, source_desc_be,
source_desc_be_fr, source_desc_bg, source_desc_ch, source_desc_cy, source_desc_cz, source_desc, source_desc_dk,
source_desc_ee, source_desc_es, source_desc_fi, source_desc_fr, source_desc_gb, source_desc_gr, source_desc_hr,
source_desc_hu, source_desc_ie, source_desc_it, source_desc_lt, source_desc_lv, source_desc_ni, source_desc_nl,
source_desc_de, source_desc_pl, source_desc_pt, source_desc_ro, source_desc_se, source_desc_si, source_desc_sk,
source_desc_cs, source_desc_mt, source_desc_us, source_desc_rs, mod_tmsp) AS SELECT source_id,
 COALESCE(MAX(CASE
    WHEN language_id = 1
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_at,
 COALESCE(MAX(CASE
    WHEN language_id = 2
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_be,
 COALESCE(MAX(CASE
    WHEN language_id = 12
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_be_fr,
 COALESCE(MAX(CASE
    WHEN language_id = 3
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_bg,
 COALESCE(MAX(CASE
    WHEN language_id = 4
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_ch,
 COALESCE(MAX(CASE
    WHEN language_id = 5
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_cy,
 COALESCE(MAX(CASE
    WHEN language_id = 6
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN source_desc
   ELSE NULL
   END) AS source_desc,
 COALESCE(MAX(CASE
    WHEN language_id = 8
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_dk,
 COALESCE(MAX(CASE
    WHEN language_id = 9
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_ee,
 COALESCE(MAX(CASE
    WHEN language_id IN (10, 31)
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_es,
 COALESCE(MAX(CASE
    WHEN language_id = 11
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_fi,
 COALESCE(MAX(CASE
    WHEN language_id = 12
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_fr,
 COALESCE(MAX(CASE
    WHEN language_id = 13
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_gb,
 COALESCE(MAX(CASE
    WHEN language_id IN (14, 5)
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_gr,
 COALESCE(MAX(CASE
    WHEN language_id = 15
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_hr,
 COALESCE(MAX(CASE
    WHEN language_id = 16
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_hu,
 COALESCE(MAX(CASE
    WHEN language_id IN (17, 21)
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_ie,
 COALESCE(MAX(CASE
    WHEN language_id IN (18, 32)
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_it,
 COALESCE(MAX(CASE
    WHEN language_id = 19
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_lt,
 COALESCE(MAX(CASE
    WHEN language_id = 20
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_lv,
 COALESCE(MAX(CASE
    WHEN language_id = 21
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_ni,
 COALESCE(MAX(CASE
    WHEN language_id = 22
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_nl,
 COALESCE(MAX(CASE
    WHEN language_id = 23
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_de,
 COALESCE(MAX(CASE
    WHEN language_id = 24
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_pl,
 COALESCE(MAX(CASE
    WHEN language_id = 25
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_pt,
 COALESCE(MAX(CASE
    WHEN language_id = 26
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_ro,
 COALESCE(MAX(CASE
    WHEN language_id = 27
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_se,
 COALESCE(MAX(CASE
    WHEN language_id = 28
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_si,
 COALESCE(MAX(CASE
    WHEN language_id = 29
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_sk,
 COALESCE(MAX(CASE
    WHEN language_id = 31
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_cs,
 COALESCE(MAX(CASE
    WHEN language_id = 32
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_mt,
 COALESCE(MAX(CASE
    WHEN language_id = 33
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_us,
 COALESCE(MAX(CASE
    WHEN language_id = 34
    THEN source_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN source_desc
    ELSE NULL
    END)) AS source_desc_rs,
 MAX(mod_tmsp) AS mod_tmsp
FROM ldl_p_lew_core_ac.v_wawi_ref_load_status_source_asis
GROUP BY source_id;