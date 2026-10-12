-- kleinster Faktor, Sortierbedingung bei Pflegefehlern nötig
 -- neuester Record bei Mehrfach-Zuordnungen bevorzugt

CREATE OR REPLACE VIEW ldl_p_lew_process.v_itm_ean_1 AS SELECT G.client_id,
 G.gtin,
 ROUND(SAFE_CAST(G.gtin AS BIGNUMERIC), 0) AS gtin_bigint,
 CAST(COALESCE(M.dwh_orig_item_nr, M.wawi_dwh_orig_item_nr) AS BIGNUMERIC) AS orig_item_nr
FROM ldl_p_lew_core_ac.v_item_gtin_hist_1 AS G
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS M ON G.client_id = M.client_id AND G.item_sid = M.item_sid
WHERE CAST(M.dwh_log_var_id AS FLOAT64) = 2
 AND CURRENT_DATE BETWEEN G.dwh_valid_from AND G.dwh_valid_to
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(G.client_id AS STRING), G.gtin ORDER BY M.wawi_dwh_dat_valid_from IS NULL
      , M.wawi_dwh_dat_valid_from, M.wawi_dwh_case_size IS NULL, M.wawi_dwh_case_size, M.item_sid IS NULL, M.item_sid))
  = 1;