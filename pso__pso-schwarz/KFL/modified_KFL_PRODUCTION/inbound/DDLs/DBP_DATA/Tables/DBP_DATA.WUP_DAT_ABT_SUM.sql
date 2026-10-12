--==============================================================
-- Table: wup_dat_abt_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_dat_abt_sum
   generated from Powerdesigner on Mittwoch, 20. November 2024 12:04:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_DAT_ABT_SUM (
   mandant_id                          INTEGER     NOT NULL COMMENT 'PK Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               INTEGER     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM-TT',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   bonanzahl                           INTEGER     COMMENT 'Anzahl der Kassenbons',
   bonanzahl_pre_pack                  INTEGER     COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln',
   bonanzahl_sug                       INTEGER     COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_DAT_ABT_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, abt_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Tages-Aggregat pro Markt und Abteilung';
