--==============================================================
-- Table: wbs_gewichte_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_gewichte_tag
   generated from Powerdesigner on Montag, 24. Januar 2022 09:19:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_gewichte_tag (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr'),
dat_von DATE OPTIONS(description='YYYY-MM-DD // Aktion gültig (von)'),
dat_bis DATE OPTIONS(description='YYYY-MM-DD // Aktion gültig (bis)'),
kategorie STRING(100)
OPTIONS(description='Kennzeichnung, der Berechnungsgrundlage zu Evaluation: stable == Original Bondatensearch == Angereicherte Daten all == Aggregierte Daten'),
anzahl_faelle BIGNUMERIC(38,0) OPTIONS(description='Die Zahl der für die Berechnung verwendeter Fälle.'),
gewicht_tag1 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 1'),
gewicht_tag5 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 5'),
gewicht_tag3 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 3'),
gewicht_tag2 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 2'),
gewicht_tag4 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 4'),
gewicht_tag11 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 11'),
gewicht_tag10 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 10'),
gewicht_tag9 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 9'),
gewicht_tag8 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 8'),
gewicht_tag7 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 7'),
gewicht_tag6 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 6'),
gewicht_tag14 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 14'),
gewicht_tag13 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 13'),
gewicht_tag12 BIGNUMERIC(38,4) OPTIONS(description='Geschätzter Anteil an Werbemenge für Tag 12'),
referenziert_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, ob die Berechnungsgrundlage mittels Referenzartikeln stabilisiert wurde.'),
wbs_level STRING(100)
OPTIONS(description='Berechnungsebene der Gewichte: item country:	3,wg_wug store: 4 ,wg store:	5,wg_wug country:	6,wg country:	7,default:	8'),
wbs_level_id BIGNUMERIC(38,0) OPTIONS(description='Id der Berechnungsebene der Gewichte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);