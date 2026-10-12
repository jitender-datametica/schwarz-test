--==============================================================
-- Table: ts_rohstoff_monitoring_nachricht_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_rohstoff_monitoring_nachricht_2
   generated from Powerdesigner on Montag, 22. September 2025 12:38:51
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_ROHSTOFF_MONITORING_NACHRICHT_2 (
   nachricht_typ_id                    NUMBER(38,0)     NOT NULL COMMENT 'Enthält die ID um welchen Nachrichtentyp es sich handelt.
            0 = Trend
            1 = Märkte
            2 = Preisbeeinflussender Faktoren',
   rohstoff_kategorie_kfl_name         VARCHAR(300)     NOT NULL COMMENT 'Kaufland interne Kategorische Zuordnung eines Rohstoffs.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   nachricht_titel_txt                 VARCHAR(1000)    NOT NULL COMMENT 'Enthält den Titel eines Textblocks im Report.',
   nachricht_inhalt_txt                VARCHAR(500000)  NOT NULL COMMENT 'Kaufland interne Beschreibung der Kategorie des Rohstoffs.',
   trend_typ_id                        NUMBER(38,0)     COMMENT 'Gibt den Trend der Rohstoffskategorie an für die Einfärbung im Report (0-2).',
   dat_trend_von                       DATE             COMMENT 'Gültigkeitsstart des Trend der Kategorie.',
   prognose_halbjahr_typ_id            NUMBER(38,0)     COMMENT 'Prognosetyp der Kategorie für das Halbjahr an (0-4).',
   nachricht_link_txt                  VARCHAR(500000)  COMMENT 'Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.',
   preis_reduzierende_faktoren_txt     VARCHAR(500000)  COMMENT 'Beschreibungen von Preisreduzierende Faktoren.',
   preis_steigernde_faktoren_txt       VARCHAR(500000)  COMMENT 'Beschreibungen von Preissteigernde Faktoren.',
   forecast_txt                        VARCHAR(500000)  COMMENT 'Enthält eine_2 Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.',
   dat_gueltig_von                     DATE             NOT NULL COMMENT 'Gültigkeitsstart des Eintrags.',
   dat_gueltig_bis                     DATE             NOT NULL COMMENT 'Gültigkeitsende des Eintrags.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_ROHSTOFF_MONITORING_NACHRICHT PRIMARY KEY (nachricht_typ_id, rohstoff_kategorie_kfl_name, spr_id, nachricht_titel_txt, nachricht_inhalt_txt) NOT ENFORCED
)  COMMENT = 'Informationen wie Trend, Märkte und preisbeeinflussender Faktoren einer Rohstoffskategorie.';
