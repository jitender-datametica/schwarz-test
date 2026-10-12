--==============================================================
-- Table: lief_plantour_arbeitsvorrat_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lief_plantour_arbeitsvorrat_1
   generated from Powerdesigner on Thursday, April 28, 2022 3:20:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LIEF_PLANTOUR_ARBEITSVORRAT_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   lief_beleg_id                       NUMBER(18,0)    NOT NULL COMMENT 'Lieferung',
   av_herkunft_id                      VARCHAR(10)     NOT NULL COMMENT 'Herkunft Arbeitsvorrat',
   wup_id                              NUMBER(38,0)    COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   plantour_id                         NUMBER(38,0)    NOT NULL COMMENT 'Plantournummer',
   vp_fg                               NUMBER(38,0)    COMMENT 'virtuelle Palette',
   stp_faktor_tour                     NUMBER(38,5)    COMMENT 'Stellplatzfaktor für Tourenplanung',
   anz_stp                             NUMBER(38,5)    COMMENT 'Summe Stellplätze',
   dat_aenderung                       DATE            COMMENT 'Datum der letzten Änderung',
   dat_lief_soll                       DATE            COMMENT 'Lieferdatum',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LIEF_PLANTOUR_ARBEITSVORRAT PRIMARY KEY (mandant_id, lief_beleg_id, av_herkunft_id) NOT ENFORCED
)  COMMENT = 'Plantouren: Arbeitsvorrat';
