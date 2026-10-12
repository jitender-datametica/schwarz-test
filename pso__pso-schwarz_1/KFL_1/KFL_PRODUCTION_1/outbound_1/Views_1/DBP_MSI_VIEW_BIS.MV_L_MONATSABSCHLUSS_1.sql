CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_monatsabschluss_1 AS SELECT MAX(kj_ker_mo_id) AS
 kjmo_abschluss
FROM kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS V01
WHERE dat_buchungs_schluss < DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY);