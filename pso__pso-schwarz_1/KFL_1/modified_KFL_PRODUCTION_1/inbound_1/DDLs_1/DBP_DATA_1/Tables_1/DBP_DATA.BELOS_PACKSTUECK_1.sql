--==============================================================
-- Table: belos_packstueck_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_packstueck_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_PACKSTUECK_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   belos_vorgang_id                    INTEGER     NOT NULL COMMENT 'Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag_1 (Logistikdaten) und einer Sendung (Abrechnungsdaten).',
   belos_packstueck_id                 INTEGER     NOT NULL COMMENT 'Eindeutige Nummer des Packstücks innerhalb eines Belos-Vorgangs',
   packstueck_gebinde_einh_id          VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Einheiten der Packstück Gebinde (z. B. Europalette)',
   packstueck_gebindeart_id            INTEGER     NOT NULL COMMENT 'Arten der Packstück Gebinde (z. B. Fleisch)',
   gebinde_anz                         INTEGER     NOT NULL COMMENT 'Anzahl gleicher Gebinde innerhalb der Packstückposition',
   bruttogew_avisiert                  NUMBER(29,3)     NOT NULL COMMENT 'Avisiertes Bruttogewicht',
   sendung_fg                          INTEGER     NOT NULL COMMENT 'Flag zum Bezug des Packstücks auf die Sendung (=1)',
   belosart_fg                         INTEGER     NOT NULL COMMENT 'Zeigt an, ob es sich bei dem Datensatz um einen Distributions- oder Beschaffungsvorgang handelt',
   nettogew_avisiert                   NUMBER(29,3)     NOT NULL COMMENT 'Avisiertes Nettogewicht. Wird aus SAP (führendes System) oder aus Belos befüllt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_PACKSTUECK PRIMARY KEY (belos_vorgang_id, belos_packstueck_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS - Die Tabelle enthaelt die Packstuecke pro Transportauftrag_1';

