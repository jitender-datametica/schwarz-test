create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_L_SEC_MANDANT_USERSEQUENZ_ZU_2(
	MANDANT_ID,
	USERSEQUENZ
) as
   SELECT mandant_id,  LOWER(usersequenz) AS usersequenz
   FROM dbp_security.ios_mandant_usersequenz_zu_2;