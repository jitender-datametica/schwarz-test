CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lead_elke_kpi_daily_lc_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
country_iso_code STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
datum DATE OPTIONS(description='calendar_2 date'),
we_paletten BIGNUMERIC(38,0)
OPTIONS(description='the amount of incoming pallets - sum of euro pallets + düsseldorf pallets/pallet factor'),
ausgelieferte_kolli BIGNUMERIC(32,0) OPTIONS(description='delivery cases'),
lagerumsatz_brutto BIGNUMERIC(38,2) OPTIONS(description='warehouse revenue gross value'),
retourenwert_brutto BIGNUMERIC(38,2) OPTIONS(description='gross retour value'),
lagerumsatz_netto BIGNUMERIC(38,2) OPTIONS(description='net value of warehouse revenue'),
retourenwert_netto BIGNUMERIC(38,2) OPTIONS(description='net retour value'),
kommissionierte_kolli BIGNUMERIC(38,5) OPTIONS(description='picked cases'),
kommissionierzeit_sec BIGNUMERIC(38,4) OPTIONS(description='picking time in sec'),
currency_iso_code STRING(3) OPTIONS(description='currency iso code')
) OPTIONS(description='LEAD - A copy of the data from LDL_PRODUCTION.P_LEW_MART_LEAD.V_LEAD_ELKE_KPI_DAILY_LC_2');