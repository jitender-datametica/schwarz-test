CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_net_vges_pweek_1 (currency_iso_cd
OPTIONS(description='Iso-Code Währung'), client_id OPTIONS(description='Landeskennzeichen'), currency_desc
OPTIONS(description='Bezeichnung der Währung'), wh_desc OPTIONS(description='Gesellschaftsbezeichnung'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), sales_manager_id
OPTIONS(description='Bezirksleiter-Nr.'), wh_id OPTIONS(description='Gesellschaftsnummer'), wh_id_exp
OPTIONS(description='Gesellschafts-Nr.-exp'), sales_manager_name OPTIONS(description='Bezirksleiter-Name'),
account_manager_id OPTIONS(description='Vertriebsleiter-Nr.'), account_manager_name
OPTIONS(description='Vertriebsleiter-Name'), move_to_store_id OPTIONS(description='Filial-Nr. nach letztem Filialumzug'),
move_store_desc OPTIONS(description='Filialname nach letztem Filialumzug'), orig_store_nr
OPTIONS(description='Original Filial-Nr.'), cy_week OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'),
cy_partial_week OPTIONS(description='Geschäftsjahr - Teilwoche Id - 1 = erster Teil / 2 = zweiter Teil der Woche_1'),
cy_partial_week_name
OPTIONS(description='Geschäftsjahr - Woche_1/Teilwoche - Name der Woche_1 - Format = JJJJ KW 99 plus "/1" für den ersten Teil oder "/2" für den zweiten Teil der Woche_1'),
country_desc OPTIONS(description='Filial-Land_1 Bezeichnung'), curr_tot_id
OPTIONS(description='Fixe Werte für EUR=0, GBP=40 sonst Client_Id'), val_retail
OPTIONS(description='Umsatz (gross value)'), val_retail_net OPTIONS(description='Umsatz (net value)'), val_retail_cum
OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (gross value)'), val_retail_net_cum
OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (net value)'), val_retail_wt_hrs_net_py
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'), val_rtl_net_wt_hrs_net_py
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'), val_retail_wt_hrs_net
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'), val_rtl_net_wt_hrs_net
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'), mt_hrs_cum
OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr'), wt_hrs_net
OPTIONS(description='Arbeitsstunden effektiv'), mt_hrs OPTIONS(description='Schulungsstunden'), wt_hrs_net_py
OPTIONS(description='Arbeitsstunden effektiv, Vorjahr'), mt_hrs_py_cum
OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr, voriges Geschäftsjahr'), wt_hrs_net_py_cum
OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr, Vorjahr'), wt_hrs_net_cum
OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr'), val_retail_wt_hrs_net_py_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net_py_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value), Vorjahr'),
val_retail_wt_hrs_net_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value)'),
val_rtl_net_wt_hrs_net_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value)'), mt_hrs_py
OPTIONS(description='Schulungsstunden, Vorjahr'))
OPTIONS(DESCRIPTION = `VIEW CONTAINS THE BASE DATA FOR THE REPORTS NETTOLEISTUNG 1104004.121 AND 1104004.321. DATA IS PROVIDED BY STORE AND PARTIAL WEEK.`)
AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_net_vges_pweek_1;