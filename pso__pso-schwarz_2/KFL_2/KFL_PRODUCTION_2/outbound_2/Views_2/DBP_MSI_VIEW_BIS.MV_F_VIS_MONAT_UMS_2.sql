CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_vis_monat_ums_2 (mandant_id, kjmo, ums_netto) AS SELECT
 mandant_id,
 kjmo,
 SUM(ums_netto) AS ums_netto
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 AS V01
WHERE wrg_id = 'EUR'
 AND akt_gj >= - 1
GROUP BY mandant_id,
 kjmo
UNION ALL
SELECT mandant_id,
  kjmo - 100 AS kjmo,
 SUM(ums_netto_kvj) AS ums_netto
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 AS V01
WHERE wrg_id = 'EUR'
 AND akt_gj = - 1
GROUP BY mandant_id,
 V01.kjmo
UNION ALL
SELECT mandant_id,
  kjmo - 200 AS kjmo,
 SUM(ums_netto_kvvj) AS ums_netto
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 AS V01
WHERE wrg_id = 'EUR'
 AND akt_gj = - 1
GROUP BY mandant_id,
 V01.kjmo;