--==============================================================
-- Table: banf_forecast_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_forecast_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BANF_FORECAST_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   banf_beleg_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Bestellanforderungsnummer - kann alphanumerische Werte enthalten',
   banf_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Positionsnummer der Bestellanforderung',
   gp_id                               INTEGER     COMMENT 'Kontonummer des Lieferanten bzw. Kreditors',
   wup_id                              INTEGER     COMMENT 'Betriebsbezogene Kundennummer',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     COMMENT 'Artikelnummer',
   dat_plan                            DATE             COMMENT 'Planungstag',
   dat_bestell                         DATE             COMMENT 'Bestelldatum',
   forecast_menge_kolli                NUMBER(29,3)     COMMENT 'Bestellmenge',
   forecast_menge_einh_id              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Bestellmengeneinheit',
   dat_lief_soll                       DATE             COMMENT 'Lieferdatum',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BANF_FORECAST PRIMARY KEY (mandant_id, banf_beleg_id, banf_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Bestellanforderung Forecast (PHIT BANF Order Forecast) - SAP RET - ZPHIT_BANF_OF';

