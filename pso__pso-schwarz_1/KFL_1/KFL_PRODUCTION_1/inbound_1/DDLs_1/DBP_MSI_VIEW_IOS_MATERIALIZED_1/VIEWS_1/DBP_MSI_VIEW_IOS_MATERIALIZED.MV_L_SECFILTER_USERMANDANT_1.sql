create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_L_SECFILTER_USERMANDANT_1(
	USER_ID,
	MANDANT_ID
) as
   SELECT
   user_id, mandant_id
   FROM dbp_security.user_mandant_msiprodukt_zu_1
   WHERE msi_produkt_bez = 'IOS';