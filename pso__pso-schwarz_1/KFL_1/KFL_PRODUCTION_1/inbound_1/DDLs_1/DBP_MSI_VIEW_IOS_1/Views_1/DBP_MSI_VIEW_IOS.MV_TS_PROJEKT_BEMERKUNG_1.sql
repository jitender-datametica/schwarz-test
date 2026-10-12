CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TS_PROJEKT_BEMERKUNG_1 as
   SELECT
   v02.projekt_id, v02.cpr_ext_id AS projekt_nr, v01.projekt_bemerkung, v01.user_id, v01.dat_aenderung, CURRENT_DATE AS dat_heute
   FROM dbp_view.v_cpr_projekt_per_1 v02
   LEFT JOIN dbp_msi_view_ios.ts_projekt_bemerkung_1 v01
   ON v01.cpr_ext_id = v02.cpr_ext_id
   WHERE v02.dat_bis = '9999-12-31'
   AND   v02.cpr_ext_id is not null;