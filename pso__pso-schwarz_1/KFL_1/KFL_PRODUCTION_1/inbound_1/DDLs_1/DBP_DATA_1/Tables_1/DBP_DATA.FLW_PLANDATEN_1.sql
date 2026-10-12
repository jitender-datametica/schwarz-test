--==============================================================
-- Table: flw_plandaten_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_plandaten_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PLANDATEN_1 (
   gjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahresmonat',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   umsatz_anlieferung_plan             NUMBER(18,4)     NOT NULL COMMENT 'Anlieferumsatz aus cm_we_fl_cur',
   rohertrag_anlieferung_plan          NUMBER(18,4)     NOT NULL COMMENT 'Anlieferrohertrag Warengruppe Fleisch (account_1: cm_are_fl_cur)',
   abschrift_inventur_plan             NUMBER(18,4)     NOT NULL COMMENT 'Inventurabschriften Warengruppe Fleisch (account_1: cm_invdiff_cur)',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PLANDATEN PRIMARY KEY (gjmo, wup_id, nb_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Planwerte für Fleischwaren pro Markt und Monat. Quelle ist Hyperion HFM';

