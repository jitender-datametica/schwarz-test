CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_b_process_objekt_zu (business_process_id, business_unit_id
, risiko_wert, pruef_feld_typ_id, aktiv_fg, planbar_fg, vorgabe_pruef_intervall, dat_vorgabe_naechst_pruef, risiko_farbe
, risiko_code) AS SELECT V01.business_process_id,
 V01.business_unit_id,
 V01.risiko_wert,
 V01.pruef_feld_typ_id,
 V01.aktiv_fg,
 V01.planbar_fg,
 V01.vorgabe_pruef_intervall,
 V01.dat_vorgabe_naechst_pruef,
  CASE
  WHEN V02.risiko_farbe = '#7401DF'
  THEN 10
  WHEN V02.risiko_farbe = '#0000FF'
  THEN 11
  WHEN V02.risiko_farbe = '#FF0000'
  THEN 12
  WHEN V02.risiko_farbe = '#FFFF00'
  THEN 13
  WHEN V02.risiko_farbe = '#00FF00'
  THEN 14
  ELSE 0
  END AS risiko_farbe,
 SUBSTR(TRIM(SUBSTR(CAST(V01.risiko_wert AS STRING), 1, 39)), 3, 1) AS risiko_code
FROM kfl_production_dbp_view.v_amx_b_process_objekt_zu AS V01
 LEFT JOIN kfl_production_dbp_view.v_amx_risiko_bewertung AS V02 ON V01.risiko_wert BETWEEN V02.risiko_wert_von AND V02
  .risiko_wert_bis
WHERE V01.amx_system_id = 1
 AND V02.amx_system_id = 1;