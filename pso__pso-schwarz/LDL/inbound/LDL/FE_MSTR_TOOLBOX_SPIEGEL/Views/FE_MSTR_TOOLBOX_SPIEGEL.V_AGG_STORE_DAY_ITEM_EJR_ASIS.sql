create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORE_DAY_ITEM_EJR_ASIS(
	CLIENT_ID,
	CURRENCY_ISO_CD,
	STORE_ID,
	ITEM_ID,
	DAT_FORMDATE,
	QTY_EJR_ASIS,
	VAL_NET_EJR_ASIS,
	MOVE_TO_STORE_ID
) as
SELECT client_id 
     , currency_iso_cd
     , store_id 
     , item_id
     , dat_formdate
     , qty_ejr_asis
     , val_net_ejr_asis
     , move_to_store_id
FROM FE_MSTR_TOOLBOX_SPIEGEL.t_agg_store_day_item_ejr_asis;
