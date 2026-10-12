--==============================================================
-- Table: art_wup_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='"Der ""WUP_1"" beinhaltet Märkte und Läger. WUP_1=WarenUmschlagsPlatz                        Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum            '),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Datum wann ein Artikel_1 zum ersten Mal in einem Markt gelistet ist'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
bezugsweg_id BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
listung_id BIGNUMERIC(38,0)
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_1 eigentlich obsolet'),
vk_brutto NUMERIC(9,3),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT            '),
kdis BIGNUMERIC(38,0)
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_1 ist über den normalen Weg bestellbar, 1: der Artikel_1 wird  zugeteilt'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_von, art_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP2 AIS - Artikel_1-Markt-Zuordnung - MULTISET	             Enthält Informationen, wie Artikel_1 den Märkten zugeordnet sind, u.a. Listung, Bezugsweg und Normal-Verkaufspreise. Keine Information über Sonderaktionen enthalten');