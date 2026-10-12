CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_buchungskreis_1 (buchungskreis_id, mandant_id, kontenplan_id,
sako_fg, td_update, td_insert) AS SELECT buchungskreis_id,
 mandant_id,
 kontenplan_id,
 sako_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_buchungskreis_1;