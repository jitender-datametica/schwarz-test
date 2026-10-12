--==============================================================
-- Table: wbs_gewichte_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_gewichte_tag_2
   generated from Powerdesigner on Montag, 24. Januar 2022 09:19:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_GEWICHTE_TAG_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   aktion_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr',
   dat_von                             DATE            COMMENT 'YYYY-MM_2-DD // Aktion_2 gültig (von)',
   dat_bis                             DATE            COMMENT 'YYYY-MM_2-DD // Aktion_2 gültig (bis)',
   kategorie                           VARCHAR(100)    COMMENT 'Kennzeichnung, der Berechnungsgrundlage zu Evaluation: stable == Original Bondatensearch == Angereicherte Daten all == Aggregierte Daten',
   anzahl_faelle                       INTEGER    COMMENT 'Die Zahl der für die Berechnung verwendeter Fälle.',
   gewicht_tag1                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 1',
   gewicht_tag5                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 5',
   gewicht_tag3                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 3',
   gewicht_tag2                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 2',
   gewicht_tag4                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 4',
   gewicht_tag11                       NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 11',
   gewicht_tag10                       NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 10',
   gewicht_tag9                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 9',
   gewicht_tag8                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 8',
   gewicht_tag7                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 7',
   gewicht_tag6                        NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 6',
   gewicht_tag14                       NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 14',
   gewicht_tag13                       NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 13',
   gewicht_tag12                       NUMBER(29,4)   COMMENT 'Geschätzter Anteil an Werbemenge für Tag_2 12',
   referenziert_fg                     INTEGER    COMMENT 'Flag, ob die Berechnungsgrundlage mittels Referenzartikeln stabilisiert wurde.',
   wbs_level                               VARCHAR(100)    COMMENT 'Berechnungsebene der Gewichte: item_2 country_2:	3,wg_wug store: 4 ,wg store:	5,wg_wug country_2:	6,wg country_2:	7,default:	8',
   wbs_level_id                            INTEGER    COMMENT 'Id der Berechnungsebene der Gewichte',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);
