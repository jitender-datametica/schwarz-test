CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_CPR_PROJEKT_AGG as

   SELECT DISTINCT
   v01.projekt_id

   FROM dbp_view.v_cpr_projekt_bauabschnitt_zu v01;