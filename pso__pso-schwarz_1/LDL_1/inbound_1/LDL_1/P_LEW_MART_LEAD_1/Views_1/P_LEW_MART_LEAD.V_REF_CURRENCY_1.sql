create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD.V_REF_CURRENCY_1(
	CURR_TOT_ID,
	COUNTRY_ID,
	CLIENT_ID,
	CURRENCY_ISO_CD,
	CURRENCY_DESC,
	TO_CURRENCY_ISO_CD,
	RATE_CURRENCY_EXCHANGE,
	LOCAL_CURRENCY_FG
) as
      SELECT
      CAST(CASE WHEN currency_iso_cd = 'EUR'
      THEN 0
    WHEN currency_iso_cd = 'GBP'
      THEN 40
    ELSE client_id
END AS SMALLINT) AS curr_tot_id,
      country_id,
      client_id,
      currency_iso_cd,
      currency_desc,
      to_currency_iso_cd,
      rate_currency_exchange,
      CAST( CASE WHEN currency_iso_cd = to_currency_iso_cd THEN 1 ELSE 0 END AS BYTEINT) AS local_currency_fg
      FROM p_lew_core_ac.v_wawi_ref_currency_act_1
;
