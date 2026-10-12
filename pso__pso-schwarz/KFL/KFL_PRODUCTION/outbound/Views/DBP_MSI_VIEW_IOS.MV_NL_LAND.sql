CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_nl_land AS SELECT DISTINCT mandant_id,
 COALESCE(kbl_nl_bez, land_id) AS kbl_nl_bez,
   TRIM(land_id) || ' / Region ' || CAST(TRIM(COALESCE(kbl_nl_bez, '')) AS STRING) AS land_nl
FROM kfl_production_dbp_view.v_cpr_projekt_per AS CPR
WHERE dat_bis = DATE '9999-12-31';