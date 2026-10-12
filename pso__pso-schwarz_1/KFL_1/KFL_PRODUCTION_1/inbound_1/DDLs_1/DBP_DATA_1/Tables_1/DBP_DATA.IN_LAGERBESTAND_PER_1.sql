--==============================================================
-- Table: in_lagerbestand_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lagerbestand_per_1
   generated from Powerdesigner on Mittwoch, 17. August 2022 20:22:29
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_LAGERBESTAND_PER_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   in_art_id                           NUMBER(38,0)    NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             NUMBER(38,0)    NOT NULL COMMENT 'Numerischer Surrogate key für das Werk',
   in_lagerort_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagerort',
   dat_von                             DATE            NOT NULL COMMENT 'Gültig von',
   dat_bis                             DATE            COMMENT 'Gültig bis',
   menge_lgbest_frei_bme               NUMBER(18,3)    COMMENT 'Bewerteter, frei verwendbarer Bestand',
   menge_lgbest_umlag_bme              NUMBER(18,3)    COMMENT 'Umlagerungsbestand (von Lagerort zu Lagerort)',
   menge_lgbest_qual_bme               NUMBER(18,3)    COMMENT 'Qualitätsprüfbestand',
   menge_lgbest_nf_charge_bme          NUMBER(18,3)    COMMENT 'Gesamtbestand aller nicht freien Chargen',
   menge_lgbest_gesp_bme               NUMBER(18,3)    COMMENT 'Gesperrter Bestand',
   menge_lgbest_ret_gesp_bme           NUMBER(18,3)    COMMENT 'Retourensperrbestand',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_LAGERBESTAND_PER PRIMARY KEY (mandant_id, in_art_id, werk_id, in_lagerort_id, dat_von) NOT ENFORCED
)  COMMENT = 'Lagerbestand pro Artikel_1/Werk aus SAP Industry (Tabelle MARD_1) auf Tagesebene in Basismengeneinheit getrennt nach frei verfügbarem Bestand / Umlagerungsbestand etc.';
