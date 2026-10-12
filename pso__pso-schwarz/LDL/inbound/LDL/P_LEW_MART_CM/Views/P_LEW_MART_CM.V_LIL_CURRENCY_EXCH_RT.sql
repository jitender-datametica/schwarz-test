create or replace view LDL_PRODUCTION.P_LEW_MART_CM.V_LIL_CURRENCY_EXCH_RT(
	FROM_CURRENCY_ISO_CD,
	TO_CURRENCY_ISO_CD,
	RATE_CURRENCY_EXCHANGE
) as
 SELECT
     from_currency_iso_cd
    ,to_currency_iso_cd
    ,rate_currency_exchange
 FROM p_lew_process_mstr_ac.v_lil_currency_exch_rt;
