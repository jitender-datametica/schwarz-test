CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_net_vges_mth_2 (client_id OPTIONS(description='Landeskennzeichen'),
wh_desc OPTIONS(description='Gesellschaftsbezeichnung'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), account_manager_id
OPTIONS(description='Vertriebsleiter-Nr.'), wh_id OPTIONS(description='Gesellschaftsnummer'), account_manager_name
OPTIONS(description='Vertriebsleiter-Name'), sales_manager_id OPTIONS(description='Bezirksleiter-Nr.'), wh_id_exp
OPTIONS(description='Gesellschafts-Nr.-exp'), sales_manager_name OPTIONS(description='Bezirksleiter-Name'),
move_to_store_id OPTIONS(description='Filial-Nr. nach letztem Filialumzug'), move_store_desc
OPTIONS(description='Filialname nach letztem Filialumzug'), orig_store_nr OPTIONS(description='Original Filial-Nr.'),
currency_iso_cd OPTIONS(description='Iso-Code Währung'), currency_desc OPTIONS(description='Bezeichnung der Währung'),
curr_tot_id OPTIONS(description='Fixe Werte für EUR=0, GBP=40 sonst Client_Id'), cy_month
OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'), cy_month_name
OPTIONS(description='Monatsname des Geschäftsjahres'), val_retail_cum
OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (gross value)'), val_retail_net_cum
OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr (net value)'), val_retail
OPTIONS(description='Umsatz (gross value)'), val_retail_net OPTIONS(description='Umsatz (net value)'), wt_hrs_net_py_cum
OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr, Vorjahr'), mt_hrs_py_cum
OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr, voriges Geschäftsjahr'), net_hrs_store_plan
OPTIONS(description='effektive Arbeitsstunden geplant'), val_retail_wt_hrs_net
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'), val_rtl_net_wt_hrs_net
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'), mt_hrs_cum
OPTIONS(description='Schulungsstunden aufgelaufen im Geschäftsjahr'), mt_hrs_py
OPTIONS(description='Schulungsstunden, Vorjahr'), net_hrs_store_plan_cum
OPTIONS(description='effektive Arbeitsstunden geplant aufgelaufen im Geschäftsjahr'), val_retail_plan_cum
OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr geplant (gross value)'), val_retail_plan_net_cum
OPTIONS(description='Umsatz aufgelaufen im Geschäftsjahr geplant (net value)'), wt_hrs_net
OPTIONS(description='Arbeitsstunden effektiv'), mt_hrs OPTIONS(description='Schulungsstunden'),
val_retail_wt_hrs_net_py_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net_py_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value), Vorjahr'),
wt_hrs_net_py OPTIONS(description='Arbeitsstunden effektiv, Vorjahr'), val_retail_wt_hrs_net_py
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'), val_rtl_net_wt_hrs_net_py
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'), wt_hrs_net_cum
OPTIONS(description='Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr'), val_retail_plan
OPTIONS(description='Umsatz geplant (gross value)'), val_retail_plan_net
OPTIONS(description='Umsatz geplant (net value)'), val_retail_wt_hrs_net_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value)'),
val_rtl_net_wt_hrs_net_cum
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value)'),
sales_pieces_plan OPTIONS(description='Abverkaufwert Plan'), sales_pieces_plan_cum
OPTIONS(description='Abverkaufwert Plan akkumuliert'))
OPTIONS(DESCRIPTION = `VIEW CONTAINS THE BASE DATA FOR THE REPORT NETTOLEISTUNG 1104004.312. DATA IS PROVIDED BY STORE AND CALENDAR_2 MONTH.`)
AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_net_vges_mth_2;