CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_miss_itm_store_day_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MIS Client ID'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key der Location_2, hier der Filiale'),
dat_formdate DATE NOT NULL OPTIONS(description='Bezugsdatum'),
day_of_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Tagesnummer der Woche_2 1-7'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'),
cy_partial_week_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
currency_iso_cd STRING(3) OPTIONS(description='3 stelliger Währungs-Code'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Interner Währungs-Code'),
miss_item_cnt INTEGER OPTIONS(description='Anzahl der Fehlartikel'),
skipped_fg INTEGER
OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value aus P_LEW_MART_LEAD.T_VT_REF_PARAMETER mit p_id = 1'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Technische Zeitstempel')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Aggregationstabelle für Fehlartikel: Granularität = client/loc_sid_store/dat_formdate');