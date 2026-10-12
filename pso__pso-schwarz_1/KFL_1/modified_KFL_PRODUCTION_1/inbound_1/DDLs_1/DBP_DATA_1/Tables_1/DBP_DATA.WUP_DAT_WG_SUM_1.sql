--==============================================================
-- Table: wup_dat_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_dat_wg_sum_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 12:04:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_DAT_WG_SUM_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'PK Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               INTEGER     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM_1-TT',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   bonanzahl                           INTEGER     COMMENT 'Anzahl der Kassenbons',
   bonanzahl_pre_pack                  INTEGER     COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln',
   bonanzahl_sug                       INTEGER     COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_DAT_WG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, wg_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Tages-Aggregat pro Markt und Warengruppe';
