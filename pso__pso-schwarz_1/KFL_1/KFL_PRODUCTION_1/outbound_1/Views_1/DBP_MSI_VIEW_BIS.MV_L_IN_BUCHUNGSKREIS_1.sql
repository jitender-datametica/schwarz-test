CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_buchungskreis_1 (buchungskreis_id, mandant_id,
kontenplan_id, sako_fg) AS SELECT buchungskreis_id,
 mandant_id,
 kontenplan_id,
 sako_fg
FROM kfl_production_dbp_view.v_in_l_buchungskreis_1
WHERE sako_fg = 1;