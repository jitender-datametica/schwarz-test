CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_load_status_kpi_asis_2 (kpi_id, kpi_group_id, kpi_desc_at, kpi_desc_be,
kpi_desc_be_fr, kpi_desc_bg, kpi_desc_ch, kpi_desc_cy, kpi_desc_cz, kpi_desc, kpi_desc_dk, kpi_desc_ee, kpi_desc_es,
kpi_desc_fi, kpi_desc_fr, kpi_desc_gb, kpi_desc_gr, kpi_desc_hr, kpi_desc_hu, kpi_desc_ie, kpi_desc_it, kpi_desc_lt,
kpi_desc_lv, kpi_desc_ni, kpi_desc_nl, kpi_desc_de, kpi_desc_pl, kpi_desc_pt, kpi_desc_ro, kpi_desc_se, kpi_desc_si,
kpi_desc_sk, kpi_desc_cs, kpi_desc_mt, kpi_desc_us, kpi_desc_rs, kpi_short_desc_at, kpi_short_desc_be,
kpi_short_desc_be_fr, kpi_short_desc_bg, kpi_short_desc_ch, kpi_short_desc_cy, kpi_short_desc_cz, kpi_short_desc,
kpi_short_desc_dk, kpi_short_desc_ee, kpi_short_desc_es, kpi_short_desc_fi, kpi_short_desc_fr, kpi_short_desc_gb,
kpi_short_desc_gr, kpi_short_desc_hr, kpi_short_desc_hu, kpi_short_desc_ie, kpi_short_desc_it, kpi_short_desc_lt,
kpi_short_desc_lv, kpi_short_desc_ni, kpi_short_desc_nl, kpi_short_desc_de, kpi_short_desc_pl, kpi_short_desc_pt,
kpi_short_desc_ro, kpi_short_desc_se, kpi_short_desc_si, kpi_short_desc_sk, kpi_short_desc_cs, kpi_short_desc_mt,
kpi_short_desc_us, kpi_short_desc_rs, kpi_source_id, kpi_level_cd, kpi_sort_rank, mod_tmsp) AS SELECT kpi_id,
 kpi_group_id,
 COALESCE(MAX(CASE
    WHEN language_id = 1
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_at,
 COALESCE(MAX(CASE
    WHEN language_id = 2
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_be,
 COALESCE(MAX(CASE
    WHEN language_id = 12
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_be_fr,
 COALESCE(MAX(CASE
    WHEN language_id = 3
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_bg,
 COALESCE(MAX(CASE
    WHEN language_id = 4
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_ch,
 COALESCE(MAX(CASE
    WHEN language_id = 5
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_cy,
 COALESCE(MAX(CASE
    WHEN language_id = 6
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN kpi_desc
   ELSE NULL
   END) AS kpi_desc,
 COALESCE(MAX(CASE
    WHEN language_id = 8
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_dk,
 COALESCE(MAX(CASE
    WHEN language_id = 9
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_ee,
 COALESCE(MAX(CASE
    WHEN language_id IN (10, 31)
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_es,
 COALESCE(MAX(CASE
    WHEN language_id = 11
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_fi,
 COALESCE(MAX(CASE
    WHEN language_id = 12
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_fr,
 COALESCE(MAX(CASE
    WHEN language_id = 13
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_gb,
 COALESCE(MAX(CASE
    WHEN language_id IN (14, 5)
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_gr,
 COALESCE(MAX(CASE
    WHEN language_id = 15
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_hr,
 COALESCE(MAX(CASE
    WHEN language_id = 16
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_hu,
 COALESCE(MAX(CASE
    WHEN language_id IN (17, 21)
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_ie,
 COALESCE(MAX(CASE
    WHEN language_id IN (18, 32)
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_it,
 COALESCE(MAX(CASE
    WHEN language_id = 19
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_lt,
 COALESCE(MAX(CASE
    WHEN language_id = 20
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_lv,
 COALESCE(MAX(CASE
    WHEN language_id = 21
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_ni,
 COALESCE(MAX(CASE
    WHEN language_id = 22
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_nl,
 COALESCE(MAX(CASE
    WHEN language_id = 23
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_de,
 COALESCE(MAX(CASE
    WHEN language_id = 24
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_pl,
 COALESCE(MAX(CASE
    WHEN language_id = 25
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_pt,
 COALESCE(MAX(CASE
    WHEN language_id = 26
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_ro,
 COALESCE(MAX(CASE
    WHEN language_id = 27
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_se,
 COALESCE(MAX(CASE
    WHEN language_id = 28
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_si,
 COALESCE(MAX(CASE
    WHEN language_id = 29
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_sk,
 COALESCE(MAX(CASE
    WHEN language_id = 31
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_cs,
 COALESCE(MAX(CASE
    WHEN language_id = 32
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_mt,
 COALESCE(MAX(CASE
    WHEN language_id = 33
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_us,
 COALESCE(MAX(CASE
    WHEN language_id = 34
    THEN kpi_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_desc
    ELSE NULL
    END)) AS kpi_desc_rs,
 COALESCE(MAX(CASE
    WHEN language_id = 1
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_at,
 COALESCE(MAX(CASE
    WHEN language_id = 2
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_be,
 COALESCE(MAX(CASE
    WHEN language_id = 12
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_be_fr,
 COALESCE(MAX(CASE
    WHEN language_id = 3
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_bg,
 COALESCE(MAX(CASE
    WHEN language_id = 4
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_ch,
 COALESCE(MAX(CASE
    WHEN language_id = 5
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_cy,
 COALESCE(MAX(CASE
    WHEN language_id = 6
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN kpi_short_desc
   ELSE NULL
   END) AS kpi_short_desc,
 COALESCE(MAX(CASE
    WHEN language_id = 8
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_dk,
 COALESCE(MAX(CASE
    WHEN language_id = 9
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_ee,
 COALESCE(MAX(CASE
    WHEN language_id IN (10, 31)
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_es,
 COALESCE(MAX(CASE
    WHEN language_id = 11
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_fi,
 COALESCE(MAX(CASE
    WHEN language_id = 12
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_fr,
 COALESCE(MAX(CASE
    WHEN language_id = 13
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_gb,
 COALESCE(MAX(CASE
    WHEN language_id IN (14, 5)
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_gr,
 COALESCE(MAX(CASE
    WHEN language_id = 15
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_hr,
 COALESCE(MAX(CASE
    WHEN language_id = 16
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_hu,
 COALESCE(MAX(CASE
    WHEN language_id IN (17, 21)
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_ie,
 COALESCE(MAX(CASE
    WHEN language_id IN (18, 32)
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_it,
 COALESCE(MAX(CASE
    WHEN language_id = 19
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_lt,
 COALESCE(MAX(CASE
    WHEN language_id = 20
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_lv,
 COALESCE(MAX(CASE
    WHEN language_id = 21
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_ni,
 COALESCE(MAX(CASE
    WHEN language_id = 22
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_nl,
 COALESCE(MAX(CASE
    WHEN language_id = 23
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_de,
 COALESCE(MAX(CASE
    WHEN language_id = 24
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_pl,
 COALESCE(MAX(CASE
    WHEN language_id = 25
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_pt,
 COALESCE(MAX(CASE
    WHEN language_id = 26
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_ro,
 COALESCE(MAX(CASE
    WHEN language_id = 27
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_se,
 COALESCE(MAX(CASE
    WHEN language_id = 28
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_si,
 COALESCE(MAX(CASE
    WHEN language_id = 29
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_sk,
 COALESCE(MAX(CASE
    WHEN language_id = 31
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_cs,
 COALESCE(MAX(CASE
    WHEN language_id = 32
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_mt,
 COALESCE(MAX(CASE
    WHEN language_id = 33
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_us,
 COALESCE(MAX(CASE
    WHEN language_id = 34
    THEN kpi_short_desc
    ELSE NULL
    END), MAX(CASE
    WHEN language_id = 7
    THEN kpi_short_desc
    ELSE NULL
    END)) AS kpi_short_desc_rs,
 kpi_source_id,
 kpi_level_cd,
 kpi_sort_rank,
 MAX(mod_tmsp) AS mod_tmsp
FROM ldl_p_lew_core_ac.v_wawi_ref_load_status_kpi_asis_2
GROUP BY kpi_id,
 kpi_group_id,
 kpi_source_id,
 kpi_level_cd,
 kpi_sort_rank;