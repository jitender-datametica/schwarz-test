--==============================================================
-- Table: l_sperrgrund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sperrgrund_2
   generated from Powerdesigner on Montag, 14. März 2022 14:06:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SPERRGRUND_2 (
   mandant_id                          INTEGER   NOT NULL COMMENT 'Mandant_2',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   wup_id                              INTEGER    NOT NULL COMMENT 'Der "WUP_2" beinhaltet Märkte und Läger. WUP_2=WarenUmschlagsPlatz. Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Nebenbetrieb',
   sperrgrund_id                       VARCHAR(1)      NOT NULL COMMENT 'LVS Sperrgrund',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SPERRGRUND PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, sperrgrund_id) NOT ENFORCED
)  COMMENT = 'Lookup Sperrgrund LVS';
