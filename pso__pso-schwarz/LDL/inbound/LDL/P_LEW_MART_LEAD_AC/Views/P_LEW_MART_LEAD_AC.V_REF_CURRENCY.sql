CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_CURRENCY
(  curr_tot_id
, country_id
, client_id
, currency_iso_cd
, currency_desc
, to_currency_iso_cd
, rate_currency_exchange
, local_currency_fg
)
AS
   SELECT
   curr_tot_id,
   country_id,
   client_id,
   currency_iso_cd,
   currency_desc,
   to_currency_iso_cd,
   rate_currency_exchange,
   local_currency_fg
   FROM p_lew_mart_lead.v_ref_currency;