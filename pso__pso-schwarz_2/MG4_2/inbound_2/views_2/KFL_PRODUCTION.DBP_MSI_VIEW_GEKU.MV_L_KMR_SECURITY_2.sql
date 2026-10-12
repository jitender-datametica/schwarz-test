create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_KMR_SECURITY_2(
	SEC_KZ,
	SEC_BEZ
) as
-- 24.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter

   SELECT
   sec_kz
   , sec_bez
   FROM dbp_msi_v_view.v_l_kmr_security_2;