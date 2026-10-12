CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_coi_ump_tag_referenz_1 (mandant_id, gj_plan, version_id,
land_level, dat_plan, dat_referenz, faktor_kalender, wert_kalender) AS SELECT mandant_id,
 gj_plan,
 version_id,
 land_level,
 dat_plan,
 dat_referenz,
 faktor_kalender,
 wert_kalender
FROM kfl_production_dbp_view.v_coi_ump_tag_referenz_1;