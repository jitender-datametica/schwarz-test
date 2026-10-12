CREATE TABLE DBP_DATA.TS_WBS_VZ_TAG_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE            NOT NULL COMMENT 'Datum',
   non_adjustable_day_fg               INTEGER    NOT NULL COMMENT 'Flag: Datum ist für die Nachversorgung als "non adjustable" markiert',
   kommentar                           VARCHAR(100)    COMMENT 'Kommentar (Non-adjustable day)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Steuertabelle WBS';
