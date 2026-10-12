CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_miss_itm_store_day_asis_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MIS Client ID'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key der Location_2, hier der Filiale'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-Key für Item_2 Id'),
dat_formdate DATE NOT NULL OPTIONS(description='Bezugsdatum'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Technische Zeitstempel')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Tabelle für Fehlartikel: Granularität = client/loc_sid_store/item_sid/dat_formdate');