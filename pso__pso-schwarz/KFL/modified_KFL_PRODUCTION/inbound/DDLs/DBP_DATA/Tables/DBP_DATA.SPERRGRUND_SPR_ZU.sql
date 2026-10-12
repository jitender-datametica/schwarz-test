--==============================================================
-- Table: sperrgrund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sperrgrund_spr_zu
   generated from Powerdesigner on Montag, 14. März 2022 14:12:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SPERRGRUND_SPR_ZU (
   mandant_id                          INTEGER   NOT NULL COMMENT 'Mandant',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   wup_id                              INTEGER    NOT NULL COMMENT 'Der "WUP" beinhaltet Märkte und Läger. WUP=WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Nebenbetrieb',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprache',
   sperrgrund_id                       VARCHAR(1)      NOT NULL COMMENT 'LVS Sperrgrund',
   sperrgrund_bez                      VARCHAR(20)     COMMENT 'LVS Sperrgrund Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SPERRGRUND_SPR_ZU PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, spr_id, sperrgrund_id) NOT ENFORCED
)  COMMENT = 'Lookup Sperrgrund LVS';
