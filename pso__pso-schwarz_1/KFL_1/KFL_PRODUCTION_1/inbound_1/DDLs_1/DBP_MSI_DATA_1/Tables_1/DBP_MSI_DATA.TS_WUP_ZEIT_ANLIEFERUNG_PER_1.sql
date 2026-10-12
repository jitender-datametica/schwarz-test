 --==============================================================
-- Table: ts_wup_zeit_anlieferung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wup_zeit_anlieferung
   generated from Powerdesigner on Freitag, 5. Januar 2024 08:30:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WUP_ZEIT_ANLIEFERUNG_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   transportsortiment_id               VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)',
   dat_von                             DATE             NOT NULL COMMENT 'Gültig von',
   dat_bis                             DATE             COMMENT 'Gültig bis',
   zeit_anlieferung                    TIME(6)          COMMENT 'Ziel-Uhrzeit für Anlieferung TIME',
   zeit_anlieferung_num                NUMBER(38,0)     COMMENT 'Ziel-Uhrzeit für Anlieferung NUMBER (time of day formated as HH24MISS and stored as number type)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WUP_ZEIT_ANLIEFERUNG PRIMARY KEY (mandant_id, wup_id, nb_id, transportsortiment_id, dat_von) NOT ENFORCED
)  COMMENT = 'Table contain exceptions for some stores with target delivery hours different from standard ';
