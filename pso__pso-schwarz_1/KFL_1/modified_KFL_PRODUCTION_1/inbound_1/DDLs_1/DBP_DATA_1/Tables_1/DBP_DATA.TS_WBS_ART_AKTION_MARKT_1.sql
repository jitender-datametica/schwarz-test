CREATE TABLE DBP_DATA.TS_WBS_ART_AKTION_MARKT_1 (
   MANDANT_ID                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   WUP_ID                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   NB_ID                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   ART_ID                              INTEGER    NOT NULL COMMENT 'Artikelnummer',
   AKTION_ID                           VARCHAR(10)     NOT NULL COMMENT 'Aktionsnummer',
   ANGEBOT_ID                          INTEGER    NOT NULL COMMENT 'Offer-ID',
   DAT_VON                             DATE            NOT NULL COMMENT 'Gültig von',
   DAT_BIS                             DATE            NOT NULL COMMENT 'Gültig bis',
   GK_FG                               INTEGER    COMMENT 'Flag: Gondelkopf',
   MENGE_MINDESTPLATZIERUNG_BME        NUMBER(29,3)    COMMENT 'Menge Mindestplatzierung in BME',
   TOP_GK_FG                           INTEGER    COMMENT 'Flag: Top_Gondelkopf',
   FIXMENGE_WFL_BME                    NUMBER(29,3)    COMMENT 'Fixmenge Warenfluss',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Artikel_1+Markt-Ebene [GK/Mindestplatzierung]';
