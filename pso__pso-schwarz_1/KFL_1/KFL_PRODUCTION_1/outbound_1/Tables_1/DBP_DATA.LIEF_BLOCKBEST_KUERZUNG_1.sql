CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_blockbest_kuerzung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Versandstelle/Warenannahmestelle'),
dat_lief_wunsch DATE NOT NULL OPTIONS(description='Lieferdatum der Position'),
lief_beleg_id INTEGER NOT NULL OPTIONS(description='Vertriebsbelegnummer'),
lief_beleg_pos_id INTEGER NOT NULL OPTIONS(description='Positionsnummer des Vertriebsbeleges'),
art_id BIGNUMERIC(38,0) OPTIONS(description='Artikelnummer'),
menge_best_kolli NUMERIC(18,3) OPTIONS(description='Bestellmenge'),
menge_lief_ist_kolli NUMERIC(18,3) OPTIONS(description='Tatsächlich gelieferte Menge in Lagermengeneinheiten'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Enthält Kürzungen aus ZBLOCKBEST_SHORT');