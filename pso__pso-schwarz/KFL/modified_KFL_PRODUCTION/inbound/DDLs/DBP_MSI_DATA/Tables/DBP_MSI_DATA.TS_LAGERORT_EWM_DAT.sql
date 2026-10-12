--==============================================================
-- Table: ts_lagerort_ewm_dat
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_lagerort_ewm_dat
   generated from Powerdesigner on Wednesday, June 8, 2022 11:12:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_LAGERORT_EWM_DAT (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH.',
   lagerort_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'ID der Lagernummer - hoechste Ebene der Lagerhierarchie.',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup ID, wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4. Stelle der Marktnummer, die Nebenbetriebskennziffer.',
   dat                                 DATE            NOT NULL COMMENT 'Datum des EWM-GoLive.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_LAGERORT_EWM_DAT PRIMARY KEY (mandant_id, lagerort_id, lagernummer_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'EWM-GoLive Date per Lagerort (starting with this date, data should be excluded from LIS reporting).';
