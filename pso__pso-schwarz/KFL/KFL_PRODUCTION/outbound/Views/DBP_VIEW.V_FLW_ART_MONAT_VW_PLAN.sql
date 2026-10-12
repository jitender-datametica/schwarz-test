CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_monat_vw_plan AS SELECT mandant_id,
 flw_art_id,
 kjmo,
 flw_vw_id,
 werk_id,
 wrg_id,
 wa_menge_kg,
 wa_menge_bme,
 wa_betrag,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_art_monat_vw_plan;