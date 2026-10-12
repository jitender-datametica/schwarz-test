CREATE OR REPLACE VIEW kfl_production_dbp_view.v_coi_ump_tag_referenz AS SELECT mandant_id,
 gj_plan,
 version_id,
 land_level,
 dat_plan,
 dat_referenz,
 wrg_id,
 faktor_kalender,
 wert_kalender,
 umsatz_netto_tag_ges
FROM kfl_production_dbp_data.coi_ump_tag_referenz;