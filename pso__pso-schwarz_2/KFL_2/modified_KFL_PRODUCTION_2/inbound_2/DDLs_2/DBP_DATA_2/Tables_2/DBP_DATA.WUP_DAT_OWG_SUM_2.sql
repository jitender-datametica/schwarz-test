--==============================================================
-- Table: wup_dat_owg_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_dat_owg_sum_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 12:04:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_DAT_OWG_SUM_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'PK Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               INTEGER     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM_2-TT',
   owg_id                              INTEGER     NOT NULL COMMENT 'ID der Oberwarengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   bonanzahl                           INTEGER     COMMENT 'Anzahl der Kassenbons',
   bonanzahl_pre_pack                  INTEGER     COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln',
   bonanzahl_sug                       INTEGER     COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_DAT_OWG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, owg_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Tages-Aggregat pro Markt und Oberwarengruppe';
