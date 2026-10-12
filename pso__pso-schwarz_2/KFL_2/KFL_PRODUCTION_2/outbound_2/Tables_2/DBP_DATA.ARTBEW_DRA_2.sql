--==============================================================
-- Table: artbew_dra_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_dra_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_dra_2 (
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
dat DATE NOT NULL OPTIONS(description='Tagesdatum in der Form JJJJ-MM_2-TT'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Eindeutige Kennung einer Aktion. Kommt aus der Kassenschnittstelle'),
promo_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2)'),
ean_kasse NUMERIC(26,0) NOT NULL OPTIONS(description='von den Kassensystemen gelieferte EAN_2'),
menge NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)'),
wrg_2 STRING(3) NOT NULL OPTIONS(description='Währung, in der der Umsatz erzielt wurde'),
umsatz_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
umsatz_mwst_betrag NUMERIC(18,4) NOT NULL
OPTIONS(description='Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, ean_kasse) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Hier sind die Umsätze von ca. 10 Märkten zu "Deutschland rundet auf" hinterlegt');