CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_in_l_buchungskreis_1 AS SELECT mandant_id,
 buchungskreis_id,
 kontenplan_id,
 sako_fg
FROM kfl_production_dbp_view.v_in_l_buchungskreis_1 AS V01;