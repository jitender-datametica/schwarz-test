--==============================================================
-- Table: wup_dat_owg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_dat_owg_sum_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 12:04:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_DAT_OWG_SUM_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'PK Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM_1-TT',
   owg_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Oberwarengruppe',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   bonanzahl                           NUMBER(38,0)     COMMENT 'Anzahl der Kassenbons',
   bonanzahl_pre_pack                  NUMBER(38,0)     COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln',
   bonanzahl_sug                       NUMBER(38,0)     COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_DAT_OWG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Tages-Aggregat pro Markt und Oberwarengruppe';
