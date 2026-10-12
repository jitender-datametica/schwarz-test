CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_wup_tag_rabatt_etikett_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
vorfall_id BIGNUMERIC(38,0) NOT NULL,
grund_id BIGNUMERIC(38,0) NOT NULL,
mde_transaktion_id STRING(50) NOT NULL,
datzeit_mde_transaktion TIMESTAMP NOT NULL,
art_id BIGNUMERIC(38,0),
kl_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.'),
gtin_id BIGNUMERIC(38,0),
dat_mhd DATE,
anz_tage_bis_ende_mhd BIGNUMERIC(38,0),
abt_id BIGNUMERIC(38,0),
wg_id BIGNUMERIC(38,0),
wug_id BIGNUMERIC(38,0),
menge_akt BIGNUMERIC(38,3),
menge_orig BIGNUMERIC(38,3),
menge_einh_id STRING(3),
vk_alt_packung_preis BIGNUMERIC(38,2),
vk_neu_packung_preis BIGNUMERIC(38,2),
vk_alt_kg_preis BIGNUMERIC(38,2),
vk_neu_kg_preis BIGNUMERIC(38,2),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
pv_prozent BIGNUMERIC(38,0),
rabatt_etikett_barcode_typ_id BIGNUMERIC(38,0),
rabatt_etikett_barcode_nr STRING(50),
rabatt_etikett_nr BIGNUMERIC(38,0),
anz_druck_rabatt_etikett BIGNUMERIC(38,0),
anz_nachdruck_rabatt_etikett BIGNUMERIC(38,0),
mobil_druck_fg BIGNUMERIC(38,0),
dat_bis_rabatt_etikett DATE,
datzeit_extrakt TIMESTAMP,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat, vorfall_id, grund_id, mde_transaktion_id) NOT ENFORCED
) OPTIONS(description='SOURCE: SAP ZRS_DISCOUNT_LAB');