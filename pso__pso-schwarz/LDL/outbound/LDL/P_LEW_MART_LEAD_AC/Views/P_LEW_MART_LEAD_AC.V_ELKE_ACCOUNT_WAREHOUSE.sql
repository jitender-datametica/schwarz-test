CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_elke_account_warehouse (client_id
OPTIONS(description='Identification of country'), wh_id OPTIONS(description='Identification of a warehouse'), busyear
OPTIONS(description='business year'), cy_month OPTIONS(description='calander month'), cy_week
OPTIONS(description='calander week'), dat_dayend OPTIONS(description='Date where receipt was booked'), currency_iso_cd
OPTIONS(description='currency used by the country'), curr_tot_id OPTIONS(description='Currency ID'), lagerumsatz_brutto
OPTIONS(description='Gutschrift minus Belastung'), lagerumsatz_brutto_lj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the current year'), lagerumsatz_brutto_vj
OPTIONS(description='warehouse revenue from previous year'), lagerumsatz_brutto_vj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the previous year'), retourenwert_brutto
OPTIONS(description='The difference between Return and correction of return'), retourenwert_brutto_lj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the current year'), retourenwert_brutto_vj
OPTIONS(description='warehouse revenue from previous year'), retourenwert_brutto_vj_aufgelaufen
OPTIONS(description='cumulative warehouse revenue mapped to the previous year'), lagerumsatz_netto_lj
OPTIONS(description='Gutschrift netto minus Belastung netto'), lagerumsatz_netto_lj_aufgelaufen
OPTIONS(description='cumulative warehouse net revenue mapped to the current year'), lagerumsatz_netto_vj
OPTIONS(description='net warehouse revenue from previous year'), lagerumsatz_netto_vj_aufgelaufen
OPTIONS(description='cumulative net warehouse revenue mapped to the previous year'), retourenwert_netto_lj
OPTIONS(description='the difference between return and correction of return in net value'),
retourenwert_netto_lj_aufgelaufen OPTIONS(description='cumulative retour net value mapped to the current year'),
retourenwert_netto_vj OPTIONS(description='net retour value mapped to the previous year'),
retourenwert_netto_vj_aufgelaufen OPTIONS(description='cumulative net retour value mapped to the previous year')) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_elke_account_warehouse;