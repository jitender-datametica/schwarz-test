CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_artb_ku_monat_wup_sum_1 AS SELECT mandant_id,
 nb_id,
 wup_id,
 kjmo,
 wrg_id AS umsatz_wrg,
 ums_netto AS umsatz_netto,
 ums_netto_kvj AS umsatz_netto_vj,
 ums_netto_kvvj AS umsatz_netto_vvj,
 ums_netto_plan AS umsatz_netto_plan,
 anz_kunde AS kunde_anz,
 anz_kunde_kvj AS kunde_anz_vj,
 anz_offen AS offen_anz,
 anz_offen_kvj AS offen_anz_vj,
 anz_offen_kvvj AS offen_anz_vvj,
 anz_kunde_kvvj,
 pers_kosten AS pk_ker,
 pers_kosten_kvj AS pk_ker_vj,
 pers_kosten_plan AS pk_ker_plan,
 rohertrag,
 rohertrag_kvj AS rohertrag_vj,
 rohertrag_plan,
 pers_std AS pers_stunden,
 pers_std_plan AS pers_stunden_plan,
 pers_std_kvj AS pers_stunden_vj,
 pers_auq AS pers_kranktage,
 pers_auq_kvj AS pers_kranktage_vj,
  CASE
  WHEN pers_auq <> 0
  THEN 1
  ELSE 0
  END AS pers_anz,
  CASE
  WHEN pers_auq_kvj <> 0
  THEN 1
  ELSE 0
  END AS pers_anz_vj,
 pers_fluq AS pers_austritte,
 pers_fluq_kvj AS pers_austritte_vj,
  CASE
  WHEN pers_fluq <> 0
  THEN 1
  ELSE 0
  END AS pers_anz_tage,
  CASE
  WHEN pers_fluq_kvj <> 0
  THEN 1
  ELSE 0
  END AS pers_anz_tage_vj,
 ums_netto AS ums_n_ker,
 ums_netto_plan AS ums_n_ker_plan,
 ums_netto_kvj AS ums_n_ker_vj,
 ums_netto_kvvj AS ums_n_ker_vvj,
 pers_kosten,
 pers_kosten_kvj AS pers_kosten_vj,
 0.00 AS pk_ker_vvj,
 0.00 AS rohertrag_vvj,
  CASE
  WHEN ums_netto_plan = 0
  THEN 1
  ELSE 0.9 * ums_netto_plan / ums_netto_plan
  END AS buchungsquote,
 0.9488 AS buchungsquote_national,
  0.0074 * anz_kunde_kvj AS we_nicht_gemeldet_anz,
 anz_kunde_kvj AS we_geb_rechnung_anz,
 0.0055 AS we_quote_national,
  0.0157 * anz_kunde_kvj AS wa_nicht_gemeldet_anz,
 anz_kunde_kvj AS wa_geb_gutschrift_anz,
 0.017 AS wa_quote_national
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS V01;