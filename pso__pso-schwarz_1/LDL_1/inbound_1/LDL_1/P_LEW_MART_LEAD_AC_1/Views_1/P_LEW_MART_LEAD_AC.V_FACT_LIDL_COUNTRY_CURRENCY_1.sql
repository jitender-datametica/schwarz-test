CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_FACT_LIDL_COUNTRY_CURRENCY_1
AS
   SELECT
        lidl_country_cd,
   curr_cd,
   client_id,
   lidl_country_name
   FROM p_lew_mart_lead.v_fact_lidl_country_currency_1;