CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_shelf_capacity_item_store_day_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MIS Client ID'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key der Location_2, hier der Filiale'),
dat_formdate DATE NOT NULL OPTIONS(description='Bezugsdatum'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'),
cy_week_partial_week_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='3 stelliger ISO-Währungs-Code'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Interner Währungs-Code'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key für Item_2 Id'),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ursprüngliche Artikelnummer (fachlice Schlüssel)'),
case_size BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Case Size (Kolli)'),
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppe ID'),
subitemgroup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unterwarengruppe ID'),
item_familygroup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelfamilie ID'),
bestand_filiale_kolli BIGNUMERIC(38,5) OPTIONS(description='Bestand in Kolli (Bestand in Stk. / Case Size)'),
regalfuellmenge_kolli BIGNUMERIC(38,5) OPTIONS(description='Regalfüllmenge in Kolli'),
restbestand_kolli BIGNUMERIC(38,5) OPTIONS(description='Regalfüllmenge in Kolli - Bestand in Kolli'),
restantenquote_fil_pct BIGNUMERIC(38,5)
OPTIONS(description='(restbestand_stk / regalfuellmenge_stk) 100 - Solange restbestand_stk positive ist.'),
regelfuellmenge_0_fg BIGNUMERIC(38,0)
OPTIONS(description='0 - regalfuellmenge_kolli > 0, 1 - regalfuellmenge_kolli = 0'),
skipped_fg BIGNUMERIC(38,0) OPTIONS(description='0 - Nicht skipped, 1 - Skipped.  Skipped = Fehlende Bestandsdatensatz'),
dwh_updated DATETIME OPTIONS(description='Technische Zeitstempel')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/item_sid');