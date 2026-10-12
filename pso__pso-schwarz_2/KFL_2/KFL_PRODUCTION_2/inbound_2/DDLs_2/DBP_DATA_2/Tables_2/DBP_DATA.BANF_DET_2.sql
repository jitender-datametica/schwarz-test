--==============================================================
-- Table: banf_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_det_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BANF_DET_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   banf_beleg_id                       NUMBER(10,0)     NOT NULL COMMENT 'Bestellanforderungsnummer',
   banf_beleg_pos_id                   NUMBER(38,0)     NOT NULL COMMENT 'Positionsnummer der Bestellanforderung',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Betrieb',
   nb_id                               NUMBER(38,0)     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   banf_menge                          NUMBER(18,3)     NOT NULL COMMENT 'Bestellanforderungsmenge',
   banf_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Mengeneinheit der Bestellanforderung',
   dat_banf_beleg                      DATE             NOT NULL COMMENT 'Anforderungsdatum',
   dat_lief_soll                       DATE             NOT NULL COMMENT 'Lieferdatum der Position',
   dat_freigabe                        DATE             NOT NULL COMMENT 'Freigabedatum der Bestellanforderung',
   banf_preis                          NUMBER(18,2)     NOT NULL COMMENT 'Preis in der Bestellanforderung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BANF_DET PRIMARY KEY (mandant_id, banf_beleg_id, banf_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Bestellanforderungen - SAP RET - EBAN';

