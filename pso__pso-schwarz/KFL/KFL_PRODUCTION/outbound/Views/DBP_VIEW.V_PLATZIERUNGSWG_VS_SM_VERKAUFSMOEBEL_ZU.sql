CREATE OR REPLACE VIEW kfl_production_dbp_view.v_platzierungswg_vs_sm_verkaufsmoebel_zu AS SELECT mandant_id,
 platzierungswg_id,
 vs_id,
 sm_id,
 verkaufsmoebel_id,
 menge_soll_flaeche,
 flaeche_einh_id
FROM kfl_production_dbp_data.platzierungswg_vs_sm_verkaufsmoebel_zu;