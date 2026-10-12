create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_REF_CURRENCY_ACT(
	COUNTRY_ID,
	CLIENT_ID,
	CURRENCY_DESC,
	CURRENCY_ISO_CD,
	TO_CURRENCY_ISO_CD,
	RATE_CURRENCY_EXCHANGE
) as
   SELECT
   country_id,
   client_id,
   currency_desc,
   currency_iso_cd,
   to_currency_iso_cd,
   rate_currency_exchange
   FROM p_lew_core.t_wawi_ref_currency_act;
