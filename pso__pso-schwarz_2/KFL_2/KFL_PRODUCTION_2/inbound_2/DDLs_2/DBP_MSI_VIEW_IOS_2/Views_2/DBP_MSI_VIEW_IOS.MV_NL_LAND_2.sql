CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_NL_LAND_2 as
   SELECT DISTINCT
   cpr.mandant_id, COALESCE(cpr.kbl_nl_bez, cpr.land_id) AS kbl_nl_bez, TRIM(cpr.land_id) || ' / Region_2 '  || TRIM(COALESCE(cpr.kbl_nl_bez, ''))::VARCHAR(40) AS land_nl
   FROM dbp_view.v_cpr_projekt_per_2 cpr

   WHERE cpr.dat_bis = '9999-12-31';