CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_retailer_2 (rtl_id, rtl_desc, rtl_desc_en, rpt_delta_sym,
rtl_desc_delta_py_perc, rtl_desc_delta_py_perc_en) AS SELECT *
FROM (SELECT DISTINCT rtl_id,
    CAST(region_rtl_desc_de AS STRING) AS region_rtl_desc,
    CAST(region_rtl_desc_en AS STRING) AS region_rtl_desc_en,
    'Δ' AS rpt_delta_sym,
    CAST(CONCAT(region_rtl_desc_de, ' ', 'Δ', 'PY%') AS STRING) AS rtl_desc_delta_py_perc,
    CAST(CONCAT(region_rtl_desc_en, ' ', 'Δ', 'PY%') AS STRING) AS rtl_desc_delta_py_perc_en
   FROM ldl_p_lew_process_mstr_ac.v_lil_region_retailer_2
   UNION ALL
   SELECT 1010 AS rtl_id,
    'Hauptwettbewerber' AS rtl_desc,
    'Main Competitor' AS rtl_desc_en,
    'Δ' AS rpt_delta_sym,
    'Hauptwettbewerber ΔPY%' AS rtl_desc_delta_py_perc,
    'Main Competitor ΔPY%' AS rtl_desc_delta_py_perc_en
   UNION ALL
   SELECT 1020 AS rtl_id,
    '2. Wettbewerber' AS rtl_desc,
    '2nd Competitor' AS rtl_desc_en,
    'Δ' AS rpt_delta_sym,
    '2. Wettbewerber ΔPY%' AS rtl_desc_delta_py_perc,
    '2nd Competitor ΔPY%' AS rtl_desc_delta_py_perc_en
   UNION ALL
   SELECT 1030 AS rtl_id,
    '3. Wettbewerber' AS rtl_desc,
    '3rd Competitor' AS rtl_desc_en,
    'Δ' AS rpt_delta_sym,
    '3. Wettbewerber ΔPY%' AS rtl_desc_delta_py_perc,
    '3rd Competitor ΔPY%' AS rtl_desc_delta_py_perc_en)
ORDER BY rtl_id NULLS LAST;