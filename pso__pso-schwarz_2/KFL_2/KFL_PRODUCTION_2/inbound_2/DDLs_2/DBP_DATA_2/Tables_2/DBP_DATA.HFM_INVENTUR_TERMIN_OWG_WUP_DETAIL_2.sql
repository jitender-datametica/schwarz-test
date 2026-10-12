--==============================================================
-- Table: hfm_inventur_termin_owg_wup_detail_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hfm_inventur_termin_owg_wup_detail_2
   generated from Powerdesigner on Donnerstag, 21. Oktober 2021 15:54:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HFM_INVENTUR_TERMIN_OWG_WUP_DETAIL_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Land_2',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Markt',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Nebenbetrieb',
   dat_plan_zaehlung                   DATE            NOT NULL COMMENT 'Zaehldatum Inventurzeitraum bis',
   inventurart_int_id                  NUMBER(38,0)    NOT NULL COMMENT 'Inventurart, z.Bsp.: 7 = Frische Inventur_2',
   owg_id                              NUMBER(38,0)    NOT NULL COMMENT 'OWG',
   arthiertyp_id                       NUMBER(38,0)    NOT NULL COMMENT 'Artikelhierarchier',
   dat_vorletzte_zaehlung              DATE            COMMENT 'Letztes Zaehldatum Inventurzeitraum von',
   wrg_id                              VARCHAR(3)      COMMENT 'Waehrung',
   anfangsbestand                      NUMBER(18,4)    COMMENT 'Anfangsbestand',
   warenzugang                         NUMBER(18,4)    COMMENT 'Warenzugang',
   warenzugang_dzl                     NUMBER(18,4)    COMMENT 'Warenzugang DZL',
   warenzugang_dzl_korr                NUMBER(18,4)    COMMENT 'Warenzugang DZL korrigiert',
   warenzugang_zl                      NUMBER(18,4)    COMMENT 'Warenzugang ZL',
   warenzugang_zl_korr                 NUMBER(18,4)    COMMENT 'Warenzugang ZL korrigiert',
   warenzugang_retoure                 NUMBER(18,4)    COMMENT 'Warenzugang Retoure',
   abschriften_ohne_diebstahl          NUMBER(18,4)    COMMENT 'Abschriften_2 ohne Diebstahl',
   werbegutschriften                   NUMBER(18,4)    COMMENT 'Werbegutschriften',
   abschriften_operativ                NUMBER(18,4)    COMMENT 'Abschriften_2 operativ',
   abschriften_ta_vt_sonstige          NUMBER(18,4)    COMMENT 'Abschriften_2 TA VT Sonstige',
   endbestand_rechnerisch              NUMBER(18,4)    COMMENT 'Rechnerischer Endbestand',
   endbestand_gezaehlt                 NUMBER(18,4)    COMMENT 'Gezaehlter Endbestand',
   umsatz_soll                         NUMBER(18,4)    COMMENT 'Soll Umsatz',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Detaildaten zu Inventurergebnissen. Daten kommen über Upload';