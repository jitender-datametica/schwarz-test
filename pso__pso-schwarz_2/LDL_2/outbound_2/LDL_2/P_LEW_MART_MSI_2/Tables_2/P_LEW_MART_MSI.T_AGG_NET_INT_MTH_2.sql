CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_agg_net_int_mth_2 (
country_group_id BIGNUMERIC(38,0) OPTIONS(description='Landesgruppe Kennzeichen'),
country_group_desc STRING(60) COLLATE 'und:ci' OPTIONS(description='Landesgruppe Bezeichnung'),
client_id BIGNUMERIC(38,0) OPTIONS(description='Landeskennzeichen'),
country_desc STRING(35) COLLATE 'und:ci' OPTIONS(description='Filial-Land_2 Bezeichnung'),
gl_region_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftsleitungsregion ID'),
gl_region_desc STRING(60) COLLATE 'und:ci' OPTIONS(description='Beschreibung Geschäftsleitungsregion'),
wh_desc STRING(50) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsbezeichnung'),
aspect_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
account_manager_id BIGNUMERIC(38,0) OPTIONS(description='Vertriebsleiter-Nr.'),
wh_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsnummer'),
account_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Vertriebsleiter-Name'),
sales_manager_id BIGNUMERIC(38,0) OPTIONS(description='Bezirksleiter-Nr.'),
wh_id_exp BIGNUMERIC(38,0) OPTIONS(description='Gesellschafts-Nr.-exp'),
sales_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezirksleiter-Name'),
move_to_store_id BIGNUMERIC(38,0) OPTIONS(description='Filialnummer nach letztem Filialumzug'),
move_store_desc STRING(255) COLLATE 'und:ci' OPTIONS(description='Filialname nach letztem Filialumzug'),
orig_store_nr BIGNUMERIC(38,0) OPTIONS(description='Original Filial-Nr.'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='Iso-Code Währung'),
currency_desc STRING(3) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Währung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte für EUR=0, GBP=40 sonst Client_Id'),
cy_month BIGNUMERIC(38,0) OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'),
cy_month_name STRING(57) COLLATE 'und:ci' OPTIONS(description='Monatsname des Geschäftsjahres'),
val_retail BIGNUMERIC(38,5) OPTIONS(description='Umsatz (gross value)'),
val_retail_net BIGNUMERIC(38,5) OPTIONS(description='Umsatz (net value)'),
val_retail_cum BIGNUMERIC(38,5) OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (gross value)'),
val_retail_net_cum BIGNUMERIC(38,5) OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (net value)'),
wt_hrs_net_py_cum BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr, Vorjahr'),
mt_hrs_py_cum BIGNUMERIC(38,5)
OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr, voriges Geschäftsjahr'),
net_hrs_store_plan BIGNUMERIC(38,5) OPTIONS(description='effektive Arbeitsstunden geplant'),
val_retail_wt_hrs_net BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'),
val_rtl_net_wt_hrs_net BIGNUMERIC(38,5) OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'),
mt_hrs_cum BIGNUMERIC(38,5) OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr'),
mt_hrs_py BIGNUMERIC(38,5) OPTIONS(description='Schulungsstunden, Vorjahr'),
net_hrs_store_plan_cum BIGNUMERIC(38,5)
OPTIONS(description='effektive Arbeitsstunden geplant aufgelaufen im Geschäftsjahr'),
val_retail_plan_cum BIGNUMERIC(38,5) OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr geplant (gross value)'),
val_retail_plan_net_cum BIGNUMERIC(38,5) OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr geplant (net value)'),
wt_hrs_net BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv'),
mt_hrs BIGNUMERIC(38,5) OPTIONS(description='Schulungsstunden'),
val_retail_wt_hrs_net_py_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net_py_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value), Vorjahr'),
wt_hrs_net_py BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv, Vorjahr'),
val_retail_wt_hrs_net_py BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net_py BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'),
wt_hrs_net_cum BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr'),
val_retail_plan BIGNUMERIC(38,5) OPTIONS(description='Umsatz geplant (gross value)'),
val_retail_plan_net BIGNUMERIC(38,5) OPTIONS(description='Umsatz geplant (net value)'),
val_retail_wt_hrs_net_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value)'),
val_rtl_net_wt_hrs_net_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value)'),
sales_pieces_plan BIGNUMERIC(38,5) OPTIONS(description='Abverkaufmenge'),
sales_pieces_plan_cum BIGNUMERIC(38,5) OPTIONS(description='Abverkaufmenge kumuliert')
) CLUSTER BY cy_month
OPTIONS(description='Monatswerte für Nettoleistung & Stückleistung');