/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20_1
#----------------------------------------------------------------------------
# History:
#  1.0  22-05-2023     Marvin Rekovsky       Initial Version of script
#  1.1  28-06-2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MIS Client ID'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key der Location_1, hier der Filiale'),
dat_formdate DATE NOT NULL OPTIONS(description='Bezugsdatum'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJWW"'),
cy_week_partial_week_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='3 stelliger ISO-Währungs-Code'),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'),
sales_net_val_day BIGNUMERIC(38,5) OPTIONS(description='Umsatz Tagesebene'),
sales_net_val_pw BIGNUMERIC(38,5) OPTIONS(description='Umsatz Teilwochenebene'),
sales_net_val_mth BIGNUMERIC(38,5) OPTIONS(description='Umsatz Monatsebene'),
sales_net_val_day_py BIGNUMERIC(38,5) OPTIONS(description='Umsatz Tagesebene VJ'),
sales_net_val_pw_py BIGNUMERIC(38,5) OPTIONS(description='Umsatz Teilwochenebene VJ'),
sales_net_val_mth_py BIGNUMERIC(38,5) OPTIONS(description='Umsatz Monatsebene VJ'),
sales_net_val_mth_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Teilwochenebene Monat_1 aufgel. (für Berechnung Umsatz Monat_1 aufgel.)'),
sales_net_val_by_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Teilwochenebene GJ aufgel. (für Berechnung Umsatz GJ aufgel.)'),
sales_net_val_mth_cum_py BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Teilwochenebene Monat_1 VJ aufgel. (für Berechnung Umsatz Monat_1 VJ aufgel.)'),
sales_net_val_by_cum_py BIGNUMERIC(38,5)
OPTIONS(description='Umsatz Teilwochenebene GJ VJ aufgel. (für Berechnung Umsatz GJ VJ aufgel.)'),
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppe ID'),
val_rtl_net_sfo_store_day BIGNUMERIC(38,5) OPTIONS(description='Tagessumme der Abschriften_1 in Landeswährung'),
val_rtl_net_sfo_store_pw BIGNUMERIC(38,5) OPTIONS(description='Teilwochensumme der Abschriften_1 in Landeswährung'),
val_rtl_net_sfo_store_mth BIGNUMERIC(38,5) OPTIONS(description='Monatssumme der Abschriften_1 in Landeswährung'),
val_rtl_net_sfo_store_day_py BIGNUMERIC(38,5) OPTIONS(description='Tagessumme der Abschriften_1 in Landeswährung VJ'),
val_rtl_net_sfo_store_wk_py BIGNUMERIC(38,5) OPTIONS(description='Teilwochensumme der Abschriften_1 in Landeswährung VJ'),
val_rtl_net_sfo_store_mth_py BIGNUMERIC(38,5) OPTIONS(description='Monatssumme der Abschriften_1 in Landeswährung VJ'),
val_rtl_net_sfo_store_mth_cum BIGNUMERIC(38,5)
OPTIONS(description='Abschriften_1 Teilwochenebene Monat_1 aufgel. (für Berechnung Abschriften_1 Monat_1 aufgel.)'),
val_rtl_net_sfo_store_by_cum BIGNUMERIC(38,5)
OPTIONS(description='Abschriften_1 Teilwochenebene GJ aufgel. (für Berechnung Abschriften_1 GJ aufgel.)'),
val_rtl_net_sfo_store_mth_cum_py BIGNUMERIC(38,5)
OPTIONS(description='Abschriften_1 Teilwochenebene Monat_1 VJ aufgel. (für Berechnung Abschriften_1 Monat_1 VJ aufgel.)'),
val_rtl_net_sfo_store_by_cum_py BIGNUMERIC(38,5)
OPTIONS(description='Abschriften_1 Teilwochenebene GJ VJ aufgel. (für Berechnung Abschriften_1 GJ VJ aufgel.)'),
val_rtl_net_sfo_qty_day BIGNUMERIC(38,5) OPTIONS(description='Tagessumme der Abschriften_1 in Stk/kg'),
val_rtl_net_sfo_qty_pw BIGNUMERIC(38,5) OPTIONS(description='Wochensumme der Abschriften_1 in Stk/kg'),
val_rtl_net_sfo_qty_mth BIGNUMERIC(38,5) OPTIONS(description='Monatssumme der Abschriften_1 in Stk/kg'),
val_rtl_net_sfo_qty_mth_cum BIGNUMERIC(38,5)
OPTIONS(description='Monat_1 aufgelaufen der Abschriften_1 in Stk/kg Teilwochenebene'),
val_rtl_net_sfo_pct_day BIGNUMERIC(38,5) OPTIONS(description='Tagessumme der Abschriften_1 in %'),
val_rtl_net_sfo_pct_pw BIGNUMERIC(38,5) OPTIONS(description='Teilwochensumme der Abschriften_1 in %'),
val_rtl_net_sfo_pct_mth BIGNUMERIC(38,5) OPTIONS(description='Monatssumme der Abschriften_1 in %'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Startdatum der Validität für Artikel_1'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Enddatum der Validität für Artikel_1'),
dwh_updated DATETIME OPTIONS(description='Technischer Zeitstempel')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Aggregierte Abschriften_1 - Schlüssel: client_id/store_id/dat_formdate');