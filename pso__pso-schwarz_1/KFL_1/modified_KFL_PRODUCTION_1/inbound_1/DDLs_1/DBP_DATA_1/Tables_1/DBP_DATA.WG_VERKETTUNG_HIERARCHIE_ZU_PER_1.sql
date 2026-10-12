--==============================================================
-- Table: wg_verkettung_hierarchie_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_verkettung_hierarchie_zu_per_1
   generated from Powerdesigner on Dienstag, 28. September 2021 15:20:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WG_VERKETTUNG_HIERARCHIE_ZU_PER_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_verkett_id                       INTEGER    NOT NULL COMMENT 'Warengruppenverkettungskennzeichen',
   wg_verkett_hier_id                  INTEGER    NOT NULL COMMENT 'LVS:Warengruppenverkettungshierarchie',
   dat_von                             DATE            NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_1-TT ',
   dat_bis                             DATE            COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Warengruppenverkettungshierarchie zuordnen';
