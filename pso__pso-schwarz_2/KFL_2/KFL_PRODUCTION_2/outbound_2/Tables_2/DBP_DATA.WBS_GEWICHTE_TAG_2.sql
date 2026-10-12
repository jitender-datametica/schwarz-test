--==============================================================
-- Table: wbs_gewichte_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_gewichte_tag_2
   generated from Powerdesigner on Montag, 24. Januar 2022 09:19:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_gewichte_tag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr'),
dat_von DATE OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gültig (von)'),
dat_bis DATE OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gültig (bis)'),
kategorie STRING(100)
OPTIONS(description='Kennzeichnung, der Berechnungsgrundlage zu Evaluation: stable == Original Bondatensearch == Angereicherte Daten all == Aggregierte Daten'),
anzahl_faelle BIGNUMERIC(38,0) OPTIONS(description='Die Zahl der für die Berechnung verwendeter Fälle.'),
gewicht_tag1 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 1'),
gewicht_tag5 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 5'),
gewicht_tag3 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 3'),
gewicht_tag2 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 2'),
gewicht_tag4 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 4'),
gewicht_tag11 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 11'),
gewicht_tag10 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 10'),
gewicht_tag9 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 9'),
gewicht_tag8 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 8'),
gewicht_tag7 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 7'),
gewicht_tag6 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 6'),
gewicht_tag14 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 14'),
gewicht_tag13 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 13'),
gewicht_tag12 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag_2 12'),
referenziert_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, ob die Berechnungsgrundlage mittels Referenzartikeln stabilisiert wurde.'),
wbs_level STRING(100)
OPTIONS(description='Berechnungsebene der Gewichte: item_2 country_2:	3,wg_wug store: 4 ,wg store:	5,wg_wug country_2:	6,wg country_2:	7,default:	8'),
wbs_level_id BIGNUMERIC(38,0) OPTIONS(description='Id der Berechnungsebene der Gewichte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);