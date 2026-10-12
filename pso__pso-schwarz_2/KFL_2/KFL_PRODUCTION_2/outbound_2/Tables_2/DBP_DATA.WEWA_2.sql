--==============================================================
-- Table: wewa_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wewa_2
   generated from Powerdesigner on Montag, 20. November 2023 17:57:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wewa_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wewa_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Belegnummer aus dem entsprechenden Satz der Tabelle best_belegfluss_2 (dort  Referenzbeleges au lfbnr)'),
wewa_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Belegposition aus dem entsprechenden Satz der Tabelle best_belegfluss_2 (dort  aus lfpos)'),
wewa_jahr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Belegjahr aus dem entsprechenden Satz der Tabelle best_belegfluss_2 (dort  aus lfgja)'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
lager_bewart_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung. Aus der Tabelle best_belegfluss_2 übernommen.'),
dat_buch DATE NOT NULL OPTIONS(description='Buchungsdatum des Beleges. Aus best_belegfluss_2 übernommen, dort aus budat'),
menge_basis BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Menge in Basismeingeneinheit aus best_belegfluss_2 ( menge)'),
betrag_ek_netto BIGNUMERIC(38,4)
OPTIONS(description='Mit dem ek_netto (Rechnungs-Einkaufspreis) bewertete Warenmenge: menge_basis * ek_netto.'),
status_2 BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status_2 analog bsch_rech_det_2, wirdbei Versorgung ermittelt: endgültig 3, gelöscht 2, vorläufig 1'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_vk_netto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='entspricht dem Attribut vkwra aus der Tabelle mseg'),
konditionsbetrag_zar5 BIGNUMERIC(38,4)
OPTIONS(description='Umsatz Betrag bei Konditionsart ZAR5 (Akt. Art. Rab.5 in %)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wewa_beleg_id, wewa_beleg_pos_id, wewa_jahr) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - Aggregat zur Darstellung des Umsatzes mit Lieferanten aus Rechnungen und wenn noch keine Rechnung vorhanden ist aus  Wareneingängen. Quelle ist die Tabelle ekbe(best_belegfluss_2)');