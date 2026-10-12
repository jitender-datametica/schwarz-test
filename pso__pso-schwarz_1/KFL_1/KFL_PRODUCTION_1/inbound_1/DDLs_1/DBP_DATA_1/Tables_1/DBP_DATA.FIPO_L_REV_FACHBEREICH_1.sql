--==============================================================
-- Table: fipo_l_rev_fachbereich_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_rev_fachbereich_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_REV_FACHBEREICH_1 (
   rev_fb_id                           NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Revisions-Fachbereichs aus rfb_id',
   aktiv_fg                            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Zeigt an, ob es sich um einen gültigen Fachbereich handelt. Aus rfb_gueltig',
   rev_fb_bez                          VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Fachbereichs aus rfb_fachbereich, z.Bsp. Filialrevision',
   rev_fb_kbez                         VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung des Fachbereichs aus rfb_kuerzel, z.Bsp. FR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_REV_FACHBEREICH PRIMARY KEY (rev_fb_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookup Tabelle der Revisions-Fachbereiche aus der Quelltabelle rev_fachbereiche';

