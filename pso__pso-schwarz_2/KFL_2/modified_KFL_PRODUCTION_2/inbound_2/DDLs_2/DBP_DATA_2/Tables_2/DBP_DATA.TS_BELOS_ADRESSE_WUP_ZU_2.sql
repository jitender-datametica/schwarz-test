--==============================================================
-- Table: ts_belos_adresse_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_belos_adresse_wup_zu_2
   generated from Powerdesigner on Friday, May 6, 2022 4:01:22 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_BELOS_ADRESSE_WUP_ZU_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   belos_adresse_id                    VARCHAR(40)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutiger Schluessel zur Identifikation einer BELOS Adresse.',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_2 ID, wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_BELOS_ADRESSE_WUP_ZU PRIMARY KEY (mandant_id, belos_adresse_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'Zuordnung BELOS-Adresse zu wup_id (wird fuer BELOS-Adressen der VZ genutzt).';
