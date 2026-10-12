CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bewertungskreis AS SELECT mandant_id,
 bewertungskreis_id,
 system_id,
 buchungskreis_id
FROM kfl_production_dbp_data.l_bewertungskreis;