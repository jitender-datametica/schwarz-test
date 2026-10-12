CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_artb_ku_monat_mandant_sum_1 AS SELECT mandant_id,
 nb_id,
 wrg_id AS umsatz_wrg,
 kjmo,
 SUM(ums_netto) AS umsatz_netto,
 SUM(ums_netto_kvj) AS umsatz_netto_vj,
 SUM(ums_netto_kvvj) AS umsatz_netto_vvj,
 SUM(ums_netto_plan) AS umsatz_netto_plan,
 SUM(anz_kunde) AS kunde_anz,
 SUM(anz_kunde_kvj) AS kunde_anz_vj,
 SUM(anz_kunde_kvvj) AS anz_kunde_kvvj,
 SUM(anz_offen) AS offen_anz,
 SUM(anz_offen_kvj) AS offen_anz_vj,
 SUM(anz_offen_kvvj) AS offen_anz_vvj,
 SUM(pers_kosten) AS pk_ker,
 SUM(pers_kosten_kvj) AS pk_ker_vj,
 SUM(pers_kosten_plan) AS pk_ker_plan,
 SUM(rohertrag) AS rohertrag,
 SUM(rohertrag_kvj) AS rohertrag_vj,
 SUM(rohertrag_plan) AS rohertrag_plan,
 SUM(pers_std) AS pers_stunden,
 SUM(pers_std_kvj) AS pers_stunden_vj,
 SUM(pers_std_plan) AS pers_stunden_plan,
 SUM(pers_auq) AS pers_kranktage,
 SUM(pers_auq_kvj) AS pers_kranktage_vj,
  CASE
  WHEN SUM(pers_auq) <> 0
  THEN 1
  ELSE 0
  END AS pers_anz,
  CASE
  WHEN SUM(pers_auq_kvj) <> 0
  THEN 1
  ELSE 0
  END AS pers_anz_vj,
  CASE
  WHEN SUM(pers_fluq) <> 0
  THEN 1
  ELSE 0
  END AS pers_anz_tage,
  CASE
  WHEN SUM(pers_fluq_kvj) <> 0
  THEN 1
  ELSE 0
  END AS pers_anz_tage_vj,
 SUM(ums_netto_plan) AS ums_n_ker_plan,
 SUM(ums_netto_kvj) AS ums_n_ker_vj,
 SUM(ums_netto_kvvj) AS ums_n_ker_vvj,
 SUM(pers_kosten) AS pers_kosten,
 SUM(pers_kosten_kvj) AS pers_kosten_vj
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS V01
GROUP BY mandant_id,
 nb_id,
 umsatz_wrg,
 kjmo;