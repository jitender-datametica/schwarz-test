create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_L_IOS_USER_SEC(
	USER_ID,
	MSI_PRODUKT_BEZ,
	TD_INSERT,
	TD_UPDATE
) as
   Select
   *
   From dbp_security.l_msi_user
   where msi_produkt_bez like 'IOS';