--==============================================================
-- Table: hfm_inventur_termin_owg_wup_detail
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hfm_inventur_termin_owg_wup_detail
   generated from Powerdesigner on Donnerstag, 21. Oktober 2021 15:54:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HFM_INVENTUR_TERMIN_OWG_WUP_DETAIL (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Land',
   wup_id                              INTEGER    NOT NULL COMMENT 'Markt',
   nb_id                               INTEGER    NOT NULL COMMENT 'Nebenbetrieb',
   dat_plan_zaehlung                   DATE            NOT NULL COMMENT 'Zaehldatum Inventurzeitraum bis',
   inventurart_int_id                  INTEGER    NOT NULL COMMENT 'Inventurart, z.Bsp.: 7 = Frische Inventur',
   owg_id                              INTEGER    NOT NULL COMMENT 'OWG',
   arthiertyp_id                       INTEGER    NOT NULL COMMENT 'Artikelhierarchier',
   dat_vorletzte_zaehlung              DATE            COMMENT 'Letztes Zaehldatum Inventurzeitraum von',
   wrg_id                              VARCHAR(3)      COMMENT 'Waehrung',
   anfangsbestand                      NUMBER(29,4)    COMMENT 'Anfangsbestand',
   warenzugang                         NUMBER(29,4)    COMMENT 'Warenzugang',
   warenzugang_dzl                     NUMBER(29,4)    COMMENT 'Warenzugang DZL',
   warenzugang_dzl_korr                NUMBER(29,4)    COMMENT 'Warenzugang DZL korrigiert',
   warenzugang_zl                      NUMBER(29,4)    COMMENT 'Warenzugang ZL',
   warenzugang_zl_korr                 NUMBER(29,4)    COMMENT 'Warenzugang ZL korrigiert',
   warenzugang_retoure                 NUMBER(29,4)    COMMENT 'Warenzugang Retoure',
   abschriften_ohne_diebstahl          NUMBER(29,4)    COMMENT 'Abschriften ohne Diebstahl',
   werbegutschriften                   NUMBER(29,4)    COMMENT 'Werbegutschriften',
   abschriften_operativ                NUMBER(29,4)    COMMENT 'Abschriften operativ',
   abschriften_ta_vt_sonstige          NUMBER(29,4)    COMMENT 'Abschriften TA VT Sonstige',
   endbestand_rechnerisch              NUMBER(29,4)    COMMENT 'Rechnerischer Endbestand',
   endbestand_gezaehlt                 NUMBER(29,4)    COMMENT 'Gezaehlter Endbestand',
   umsatz_soll                         NUMBER(29,4)    COMMENT 'Soll Umsatz',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Detaildaten zu Inventurergebnissen. Daten kommen über Upload';