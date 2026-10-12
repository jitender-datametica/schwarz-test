CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_agg_net_vges_pweek_det (
cy_week BIGNUMERIC(38,0) OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'),
cy_partial_week BIGNUMERIC(38,0)
OPTIONS(description='Geschäftsjahr - Teilwoche Id - 1 = erster Teil / 2 = zweiter Teil der Woche'),
cy_partial_week_name STRING(27) COLLATE 'und:ci'
OPTIONS(description='Geschäftsjahr - Woche/Teilwoche - Name der Woche - Format = JJJJ KW 99 plus "/1" für den ersten Teil oder "/2" für den zweiten Teil der Woche'),
dat_calendar DATE OPTIONS(description='Belegdatum'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='Iso-Code Währung'),
client_id BIGNUMERIC(38,0) OPTIONS(description='Landeskennzeichen'),
currency_desc STRING(3) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Währung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte für EUR=0, GBP=40 sonst Client_Id'),
wh_desc STRING(50) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsbezeichnung'),
move_to_store_id BIGNUMERIC(38,0) OPTIONS(description='Filial-Nr. nach letztem Filialumzug'),
aspect_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
move_store_desc STRING(255) COLLATE 'und:ci' OPTIONS(description='Filialname nach letztem Filialumzug'),
orig_store_nr BIGNUMERIC(38,0) OPTIONS(description='Original Filial-Nr.'),
sales_manager_id BIGNUMERIC(38,0) OPTIONS(description='Bezirksleiter-Nr.'),
wh_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsnummer'),
wh_id_exp BIGNUMERIC(38,0) OPTIONS(description='Gesellschafts-Nr.-exp'),
sales_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezirksleiter-Name'),
account_manager_id BIGNUMERIC(38,0) OPTIONS(description='Vertriebsleiter-Nr.'),
account_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Vertriebsleiter-Name'),
cy_week_desc STRING(10) COLLATE 'und:ci' OPTIONS(description='Geschäftsjahr - Woche Bezeichnung'),
val_retail_cum BIGNUMERIC(38,5) OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (gross value)'),
val_retail_net_cum BIGNUMERIC(38,5) OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (net value)'),
val_retail BIGNUMERIC(38,5) OPTIONS(description='Umsatz (gross value)'),
val_retail_net BIGNUMERIC(38,5) OPTIONS(description='Umsatz (net value)'),
val_retail_wt_hrs_net_py BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net_py BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'),
val_retail_wt_hrs_net BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'),
val_rtl_net_wt_hrs_net BIGNUMERIC(38,5) OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'),
mt_hrs_cum BIGNUMERIC(38,5) OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr'),
wt_hrs_net BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv'),
mt_hrs BIGNUMERIC(38,5) OPTIONS(description='Schulungsstunden'),
wt_hrs_net_py BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv, Vorjahr'),
mt_hrs_py_cum BIGNUMERIC(38,5)
OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr, voriges Geschäftsjahr'),
wt_hrs_net_py_cum BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr, Vorjahr'),
wt_hrs_net_cum BIGNUMERIC(38,5) OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr'),
val_retail_wt_hrs_net_py_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net_py_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value), Vorjahr'),
val_retail_wt_hrs_net_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value)'),
val_rtl_net_wt_hrs_net_cum BIGNUMERIC(38,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value)'),
mt_hrs_py BIGNUMERIC(38,5) OPTIONS(description='Schulungsstunden, Vorjahr')
) CLUSTER BY cy_week
OPTIONS(description='Table contains the base data for the Report Nettoleistung 1104004.322. Data is provided by store and day.');