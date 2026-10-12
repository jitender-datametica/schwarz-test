CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_wbs_art_aktion_markt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Aktionsnummer'),
angebot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Offer-ID'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE NOT NULL OPTIONS(description='Gültig bis'),
gk_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Gondelkopf'),
menge_mindestplatzierung_bme NUMERIC(18,3) OPTIONS(description='Menge Mindestplatzierung in BME'),
top_gk_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Top_Gondelkopf'),
fixmenge_wfl_bme NUMERIC(18,3) OPTIONS(description='Fixmenge Warenfluss'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Artikel_2+Markt-Ebene [GK/Mindestplatzierung]');