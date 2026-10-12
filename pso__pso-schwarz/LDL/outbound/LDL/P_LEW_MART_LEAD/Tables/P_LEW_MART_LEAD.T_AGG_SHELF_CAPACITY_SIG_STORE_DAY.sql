CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_shelf_capacity_sig_store_day (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MIS Client ID'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key der Location, hier der Filiale'),
dat_formdate DATE NOT NULL OPTIONS(description='Bezugsdatum'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'),
cy_week_partial_week_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat des Geschäftsjahres im Format "JJJJMM"'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='3 stelliger ISO-Währungs-Code'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Interner Währungs-Code'),
subitemgroup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unterwarengruppe ID'),
restantenquote_fil_pct BIGNUMERIC(38,5)
OPTIONS(description='Durchschnitt aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY restantenquote_fil'),
regelfuellmenge_0_cnt BIGNUMERIC(38,0)
OPTIONS(description='Summe aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY regelfuellmenge_0'),
skipped_cnt BIGNUMERIC(38,0) OPTIONS(description='Summe aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY skipped_fg'),
dwh_updated DATETIME OPTIONS(description='Technische Zeitstempel')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Aggregierte Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/sig');