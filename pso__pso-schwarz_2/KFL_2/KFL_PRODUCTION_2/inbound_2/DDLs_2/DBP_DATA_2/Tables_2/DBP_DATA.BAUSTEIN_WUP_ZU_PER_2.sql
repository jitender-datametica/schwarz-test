--==============================================================
-- Table: baustein_wup_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_wup_zu_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BAUSTEIN_WUP_ZU_PER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende des Gültigkeitszeitraums Format ''YYYY-MM_2-DD''',
   baustein_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   dat_von                             DATE             COMMENT 'Beginn des Gültigkeitszeitraums Format ''YYYY-MM_2-DD''',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BAUSTEIN_WUP_ZU_PER PRIMARY KEY (mandant_id, wup_id, nb_id, dat_bis, baustein_id) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Zuordnung Baustein zu Wup_2 - MULTISET';

