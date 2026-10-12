CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_MONATSABSCHLUSS_1 as
   SELECT

   MAX(v01.kj_ker_mo_id) AS kjmo_abschluss

   FROM dbp_view.v_l_buchungsstatus_ker_1 v01

   WHERE dat_buchungs_schluss < CURRENT_DATE - 1
;