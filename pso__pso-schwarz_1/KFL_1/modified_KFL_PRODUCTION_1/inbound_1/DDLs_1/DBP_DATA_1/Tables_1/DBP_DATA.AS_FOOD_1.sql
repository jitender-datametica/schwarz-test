--==============================================================
-- Table: as_food_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: as_food_1
   generated from Powerdesigner on Donnerstag, 8. September 2022 15:47:16
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AS_FOOD_1 (
   art_id                              INTEGER    NOT NULL COMMENT 'Artikelnummer im DWH',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   dat_auslistung                      DATE            NOT NULL COMMENT 'Das Datum der Auslistung aus dem Quellfeld aldat',
   gp_id                               INTEGER    DEFAULT -1 NOT NULL COMMENT 'Geschaeftspartner - ID (Lieferanten - ID)',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   phase_status                        INTEGER    DEFAULT -1 NOT NULL COMMENT 'Vermarktungsstatus aus dem Quellfeld vstatus',
   erl_fg                              INTEGER    DEFAULT 0 NOT NULL COMMENT 'Erledigt Flag aus dem Quellfeld erlkz (0=('''',''B''); restlichen Auspraegungen = 1 (''A'',''C'',''D'';''E'',''F'',''G'',''X''))',
   dat_final                           DATE            COMMENT 'Datum Laufzeitende aus dem Quellfeld final',
   menge_startbestand                  NUMBER(29,3)    DEFAULT 0 NOT NULL COMMENT 'Redundant. Aus Tabelle marktbestand_erp_1 ermittelte Menge',
   vk_netto                            NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Redundant. Verkaufspreis netto aus der Tabelle marktbestand_erp_zu_1',
   menge_endbestand                    NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Endbestand',
   erl_kz                              VARCHAR(1)      COLLATE 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Redundant zu "erl_fg" die einzelnen Auspraegungen (Erledigt Flag aus dem Quellfeld erlkz (0=('''',''B''); restlichen Ausprägungen = 1 (''A'',''C'',''D'';''E'',''F'',''G'',''X'')))',
   dat_aend                            DATE            COMMENT 'Aenderungsdatum',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AS_FOOD PRIMARY KEY (art_id, mandant_id, nb_id, wup_id, dat_auslistung) NOT ENFORCED
)  COMMENT = 'AIS - Auslistungs-Schema Kopftabelle aus der Quelltabelle zrs_rvdata';
