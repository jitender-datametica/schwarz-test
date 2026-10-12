--==============================================================
-- Table: banf_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_det
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BANF_DET (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   banf_beleg_id                       INTEGER     NOT NULL COMMENT 'Bestellanforderungsnummer',
   banf_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Positionsnummer der Bestellanforderung',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer',
   wup_id                              INTEGER     NOT NULL COMMENT 'Betrieb',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   banf_menge                          NUMBER(29,3)     NOT NULL COMMENT 'Bestellanforderungsmenge',
   banf_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Mengeneinheit der Bestellanforderung',
   dat_banf_beleg                      DATE             NOT NULL COMMENT 'Anforderungsdatum',
   dat_lief_soll                       DATE             NOT NULL COMMENT 'Lieferdatum der Position',
   dat_freigabe                        DATE             NOT NULL COMMENT 'Freigabedatum der Bestellanforderung',
   banf_preis                          NUMBER(29,2)     NOT NULL COMMENT 'Preis in der Bestellanforderung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BANF_DET PRIMARY KEY (mandant_id, banf_beleg_id, banf_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Bestellanforderungen - SAP RET - EBAN';

