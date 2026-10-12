CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_plandaten_2 (gjmo, kjmo, wup_id, nb_id, mandant_id,
umsatz_anlieferung_plan, rohertrag_anlieferung_plan, abschrift_inventur_plan, wrg_id) AS SELECT V01.gjmo,
 V02.kjmo,
 V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.umsatz_anlieferung_plan,
 V01.rohertrag_anlieferung_plan,
 V01.abschrift_inventur_plan,
 V01.wrg_id
FROM kfl_production_dbp_view.v_flw_plandaten_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS V02 ON V01.gjmo = V02.gjmo;