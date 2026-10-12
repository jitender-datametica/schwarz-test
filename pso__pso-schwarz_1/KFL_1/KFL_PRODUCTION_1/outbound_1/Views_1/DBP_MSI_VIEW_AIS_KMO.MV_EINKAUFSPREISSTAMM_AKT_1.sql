CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_einkaufspreisstamm_akt_1 AS SELECT V01.mandant_id,
 V01.art_id,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_nettonetto, 0)
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_nettonetto, 0) * V01.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS ek2_nettonetto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.einstandspreis, 0)
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.einstandspreis, 0) * V01.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS ek4_einstandspreis
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_einkaufspreisstamm_akt_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE;