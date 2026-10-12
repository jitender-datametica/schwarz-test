--==============================================================
-- Table: rohstoff_gruppe_nachricht_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_gruppe_nachricht_2
   generated from Powerdesigner on Mittwoch, 22. Oktober 2025 17:54:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ROHSTOFF_GRUPPE_NACHRICHT_2 (
   rohstoff_gruppe_typ_id              INTEGER     NOT NULL COMMENT 'ID des Gruppierungstyps eines Rohstoffs.',
   rohstoff_gruppe_name                VARCHAR(100)     NOT NULL COMMENT 'Name der Gruppe_2 eines Rohstoffs nach Gruppierungstyp.',
   nachricht_typ_id                    INTEGER     NOT NULL COMMENT 'Enthält die ID um welchen Nachrichtentyp es sich handelt.
            0 = Trend
            1 = Märkte
            2 = Preisbeeinflussender Faktoren',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   nachricht_titel_txt                 VARCHAR(1000)    NOT NULL COMMENT 'Enthält den Titel einesTextblocks im Report.',
   nachricht_inhalt_txt                VARCHAR(500000)  NOT NULL COMMENT 'Kaufland interne Beschreibung der Rohstoffgruppe des Rohstoffs.',
   trend_typ_id                        INTEGER     COMMENT 'Gibt den Trend der Rohstoffsgruppe an für die Einfärbung im Report (0-2).
            0 =  Aufwaertstrend
            1 =  Abwaertstrend
            2 =  Seitwaertstrend',
   dat_trend_von                       DATE             COMMENT 'Gültigkeitsstart des Trend der Rohstoffsgruppe.',
   prognose_halbjahr_typ_id            INTEGER     COMMENT 'Prognosetyp der Rohstoffsgruppe für das Halbjahr an (0-4).
            0  =  >+20%
            1  =  +5 -20%
            2  =  bis + -5%
            3  = -5 -20 %
            4  = > -20%',
   nachricht_link_txt                  VARCHAR(500000)  COMMENT 'Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.',
   preis_reduzierende_faktoren_txt     VARCHAR(500000)  COMMENT 'Beschreibungen von Preisreduzierende Faktoren.',
   preis_steigernde_faktoren_txt       VARCHAR(500000)  COMMENT 'Beschreibungen von Preissteigernde Faktoren.',
   forecast_txt                        VARCHAR(500000)  COMMENT 'Enthält eine_2 Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.',
   dat_gueltig_von                     DATE             NOT NULL COMMENT 'Gültigkeitsstart des Eintrags.',
   dat_gueltig_bis                     DATE             NOT NULL COMMENT 'Gültigkeitsende des Eintrags',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ROHSTOFF_GRUPPE_NACHRICHT PRIMARY KEY (rohstoff_gruppe_typ_id, rohstoff_gruppe_name, nachricht_typ_id, spr_id, nachricht_titel_txt, nachricht_inhalt_txt) NOT ENFORCED
)  COMMENT = 'Nachrichten (Trend, Markt und Prognose) über Rohstoffskategorie.';
