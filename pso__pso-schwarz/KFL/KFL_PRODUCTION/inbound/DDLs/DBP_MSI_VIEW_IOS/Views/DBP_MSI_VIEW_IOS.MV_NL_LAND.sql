CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_NL_LAND as
   SELECT DISTINCT
   cpr.mandant_id, COALESCE(cpr.kbl_nl_bez, cpr.land_id) AS kbl_nl_bez, TRIM(cpr.land_id) || ' / Region '  || TRIM(COALESCE(cpr.kbl_nl_bez, ''))::VARCHAR(40) AS land_nl
   FROM dbp_view.v_cpr_projekt_per cpr

   WHERE cpr.dat_bis = '9999-12-31';