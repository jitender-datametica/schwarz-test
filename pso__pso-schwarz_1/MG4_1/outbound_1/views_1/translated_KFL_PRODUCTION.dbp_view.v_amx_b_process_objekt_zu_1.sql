CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_b_process_objekt_zu_1 (business_process_id, business_unit_id,
amx_system_id, risiko_wert, pruef_feld_typ_id, aktiv_fg, planbar_fg, vorgabe_pruef_intervall, dat_vorgabe_naechst_pruef
, audit_universe_id, td_insert, td_update) AS SELECT *
FROM kfl_production_dbp_data.amx_b_process_objekt_zu_1;