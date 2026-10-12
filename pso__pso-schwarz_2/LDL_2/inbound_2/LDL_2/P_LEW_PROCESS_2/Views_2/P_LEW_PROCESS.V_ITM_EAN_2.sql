CREATE OR REPLACE VIEW P_LEW_PROCESS.V_ITM_EAN_2
AS
   SELECT
   g.client_id,
   g.gtin,
   TRY_CAST(g.gtin AS BIGINT) AS gtin_bigint,
   CAST(COALESCE(m.dwh_orig_item_nr,m.wawi_dwh_orig_item_nr) AS BIGINT) AS orig_item_nr
   FROM p_lew_core_ac.v_item_gtin_hist_2 g
   INNER JOIN p_lew_core_ac.v_item_map_key_2 m
   ON m.client_id=g.client_id
   AND m.item_sid=g.item_sid

   WHERE m.dwh_log_var_id=2
   AND CURRENT_DATE BETWEEN g.dwh_valid_from AND g.dwh_valid_to
   QUALIFY ROW_NUMBER() OVER (PARTITION BY g.client_id, g.gtin
   ORDER BY m.wawi_dwh_dat_valid_from DESC NULLS LAST, -- neuester Record bei Mehrfach-Zuordnungen bevorzugt
       m.wawi_dwh_case_size ASC, -- kleinster Faktor, Sortierbedingung bei Pflegefehlern nötig
       m.item_sid ASC ) = 1
;