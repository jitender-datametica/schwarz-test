--==============================================================
-- Table: ts_bestwertfortschreibung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_bestwertfortschreibung_2
   generated from Powerdesigner on Donnerstag, 12. Oktober 2023 11:23:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_BESTWERTFORTSCHREIBUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetrieb z.Bsp.: 0 = Markt',
   dat                                 DATE             NOT NULL COMMENT 'Tag_2 für den die manuellen Eingaben getätigt werden',
   owg_id                              INTEGER     NOT NULL COMMENT 'ID der Oberwarengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Hierarchietyp Seit 2010 immer 2',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Landeswährung - Pflege über Frontend, abhängig vom Mandant_2',
   umsatz_plan_brutto_owg              NUMBER(29,4)     COMMENT 'Planwert Umsatz HL_2 brutto - Pflege über Frontend',
   wareneingang_brutto_owg             NUMBER(29,4)     COMMENT 'Wareneingang brutto - IST - Pflege über Frontend',
   schlussbestand_vormonat_brutto_owg  NUMBER(29,4)     COMMENT 'Voraussichtlicher Schlussbestand Brutto Vormonat - IST - Pflege über Frontend',
   datzeit_pflege                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'datzeit_pflege zur Kontrolle bei druecken Button speichern',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_BESTWERTFORTSCHREIBUNG PRIMARY KEY (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id, wrg_id) NOT ENFORCED
)  COMMENT = 'VIS - Transaction Frontend - Pflegetabelle für VIS Bericht Bestellfortschreibung.';
