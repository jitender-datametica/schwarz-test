--==============================================================
-- Table: sperrgrund_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sperrgrund_spr_zu_2
   generated from Powerdesigner on Montag, 14. März 2022 14:12:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SPERRGRUND_SPR_ZU_2 (
   mandant_id                          NUMBER(38, 0)   NOT NULL COMMENT 'Mandant_2',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Der "WUP_2" beinhaltet Märkte und Läger. WUP_2=WarenUmschlagsPlatz. Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Nebenbetrieb',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprache',
   sperrgrund_id                       VARCHAR(1)      NOT NULL COMMENT 'LVS Sperrgrund',
   sperrgrund_bez                      VARCHAR(20)     COMMENT 'LVS Sperrgrund Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SPERRGRUND_SPR_ZU PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, spr_id, sperrgrund_id) NOT ENFORCED
)  COMMENT = 'Lookup Sperrgrund LVS';
