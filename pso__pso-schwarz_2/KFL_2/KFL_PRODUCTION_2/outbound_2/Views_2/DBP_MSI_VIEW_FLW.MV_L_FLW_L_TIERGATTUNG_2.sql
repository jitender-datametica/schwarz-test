CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_tiergattung_2 AS SELECT V01.mandant_id,
 V01.tiergattung_id,
 V02.mandant_kbez
FROM kfl_production_dbp_view.v_flw_l_tiergattung_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id;