--==============================================================
-- Table: ts_rohstoff_monitoring_anzeige_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_rohstoff_monitoring_anzeige_2
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 11:07:23
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_ROHSTOFF_MONITORING_ANZEIGE_2 (
   rohstoff_nr                         VARCHAR(20)      NOT NULL COMMENT 'Mintecs Interne ID des Rohstoffs.',
   rohstoff_kategorie_kfl_name         VARCHAR(300)     NOT NULL COMMENT 'Kaufland interne Kategorische Zuordnung des Rohstoffs.',
   rohstoff_kfl_bez                    VARCHAR(300)     NOT NULL COMMENT 'Kaufland interne Bezeichnung des Rohstoffs.',
   rohstoff_subkategorie_kfl_name      VARCHAR(300)     COMMENT 'Kaufland interne Subkategorische Zuordnung des Rohstoffs.',
   rohstoff_blend_kfl_txt              VARCHAR(300)     COMMENT 'Gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.',
   rohstoff_qualitaet_txt              VARCHAR(1000)    COMMENT 'Beschreibung der Qualität des Rohstoffs.',
   rohstoff_quell_bez                  VARCHAR(200)     COMMENT 'Enthält Informationen zur Quelle des Rohstoffes.',
   rohstoff_cluster_id                 INTEGER     COMMENT 'Rohstoffe können für eine_2 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.',
   dat_anzeige_von                     DATE             COMMENT 'Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.',
   dat_anzeige_bis                     DATE             COMMENT 'Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_ROHSTOFF_MONITORING_ANZEIGE PRIMARY KEY (rohstoff_nr, rohstoff_kategorie_kfl_name) NOT ENFORCED
)  COMMENT = 'KFL Informationen über Rohstoff.';
