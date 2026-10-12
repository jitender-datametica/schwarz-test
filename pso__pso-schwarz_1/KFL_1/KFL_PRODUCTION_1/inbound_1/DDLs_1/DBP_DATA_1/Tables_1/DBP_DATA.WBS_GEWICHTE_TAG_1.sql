--==============================================================
-- Table: wbs_gewichte_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_gewichte_tag_1
   generated from Powerdesigner on Montag, 24. Januar 2022 09:19:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_GEWICHTE_TAG_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   aktion_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr',
   dat_von                             DATE            COMMENT 'YYYY-MM_1-DD // Aktion_1 gültig (von)',
   dat_bis                             DATE            COMMENT 'YYYY-MM_1-DD // Aktion_1 gültig (bis)',
   kategorie                           VARCHAR(100)    COMMENT 'Kennzeichnung, der Berechnungsgrundlage zu Evaluation: stable == Original Bondatensearch == Angereicherte Daten all == Aggregierte Daten',
   anzahl_faelle                       NUMBER(38,0)    COMMENT 'Die Zahl der für die Berechnung verwendeter Fälle.',
   gewicht_tag1                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 1',
   gewicht_tag5                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 5',
   gewicht_tag3                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 3',
   gewicht_tag2                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 2',
   gewicht_tag4                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 4',
   gewicht_tag11                       NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 11',
   gewicht_tag10                       NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 10',
   gewicht_tag9                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 9',
   gewicht_tag8                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 8',
   gewicht_tag7                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 7',
   gewicht_tag6                        NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 6',
   gewicht_tag14                       NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 14',
   gewicht_tag13                       NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 13',
   gewicht_tag12                       NUMERIC(38,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_1 12',
   referenziert_fg                     NUMBER(38,0)    COMMENT 'Flag, ob die Berechnungsgrundlage mittels Referenzartikeln stabilisiert wurde.',
   wbs_level                               VARCHAR(100)    COMMENT 'Berechnungsebene der Gewichte: item_1 country_1:	3,wg_wug store: 4 ,wg store:	5,wg_wug country_1:	6,wg country_1:	7,default:	8',
   wbs_level_id                            NUMBER(38,0)    COMMENT 'Id der Berechnungsebene der Gewichte',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);
