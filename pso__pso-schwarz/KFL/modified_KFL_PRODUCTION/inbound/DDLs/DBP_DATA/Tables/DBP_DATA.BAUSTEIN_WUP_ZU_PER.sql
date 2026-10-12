--==============================================================
-- Table: baustein_wup_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_wup_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BAUSTEIN_WUP_ZU_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende des Gültigkeitszeitraums Format ''YYYY-MM-DD''',
   baustein_id                         INTEGER     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   dat_von                             DATE             COMMENT 'Beginn des Gültigkeitszeitraums Format ''YYYY-MM-DD''',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BAUSTEIN_WUP_ZU_PER PRIMARY KEY (mandant_id, wup_id, nb_id, dat_bis, baustein_id) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Zuordnung Baustein zu Wup - MULTISET';

