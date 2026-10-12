--==============================================================
-- Table: banf_art_gp_dat_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_art_gp_dat_sum
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.banf_art_gp_dat_sum (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) aus art_wup_ordersatz'),
dat_lief_soll DATE NOT NULL
OPTIONS(description='Datum im Format JJJJ-MM-TT - (banf_det.dat_lief_soll; banf_forecast.dat_lief_soll; besch_bestaetigung.dat_lief_plan (EKET))'),
in_aktion_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dat_kalk DATE NOT NULL OPTIONS(description='Kalkulationsdatum'),
vk_brutto NUMERIC(9,2) NOT NULL
OPTIONS(description='Verkaufspreis brutto (aus art_wup_vk_pe.vk_bruttor; wenn in Aktion, dann aus aktion_art_wup_zu.vk_aktion_brutto'),
banf_menge_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Bestellanforderungsmenge aus banf_det.banf_menge und Umrechnung in Kolli'),
forecast_menge_kolli NUMERIC(18,3)
OPTIONS(description='Bestellmenge auf banf_forecast.forecast_menge_kolli (bereits in der Einheit Kolli)'),
menge_best_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per ermittelt.'),
banf_menge_kg NUMERIC(18,3) NOT NULL
OPTIONS(description='Bestellanforderungsmenge in kg (Umrechnung in kg über Feld banf_det.banf_menge (wenn nicht in kg, dann Ermittlung über EORD->EINA->MARM))'),
forecast_menge_kg NUMERIC(18,3)
OPTIONS(description='Bestellmenge in kg (Umrechnung in kg über Feld banf_forecast.forecast_menge (wenn nicht in kg, dann Ermittlung über EORD->EINA->MARM))'),
menge_best_kg NUMERIC(18,3) NOT NULL
OPTIONS(description='bestellte Menge des Artikel  (wenn besch_best_det.best_menge_einh_id = KG dann besch_best_det.menge_best_bme Sonst Umrechnung über MARM)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, gp_id, dat_lief_soll, in_aktion_fg, dat_kalk) NOT ENFORCED
)
OPTIONS(description='FLW - Aggregat der Bestellanforderungen und Bestellungen auf Ebene Artikel/Markt/Tag - wird im Beladeprozess gebildet');