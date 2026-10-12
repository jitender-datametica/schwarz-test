--==============================================================
-- Table: ivs_debitor_kontostand
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ivs_debitor_kontostand
   generated from Powerdesigner on Montag, 26. Juli 2021 10:37:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ivs_debitor_kontostand (
   debitor_id                          INTEGER    NOT NULL COMMENT 'Eindeutige ID eines Debitors',
   abzug_id                            INTEGER    NOT NULL COMMENT 'Eindeutige ID fuer die Art und Zeitpunkt des Datenabzugs.',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant',
   kjmo                                INTEGER    NOT NULL COMMENT 'Kalenderjahr/Monat',
   mietvertrag_id                      VARCHAR(20)     collate 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'Entspricht mv_intreno aus IMMO',
   wup_id                              INTEGER    DEFAULT 0 NOT NULL COMMENT 'Marktnummer',
   buchungskreis_id                    INTEGER    COMMENT 'SAP Buchungskreis',
   wrg_id                              VARCHAR(3)      collate 'en-ci' COMMENT 'Waehrung',
   sonderhauptbuch_id                  VARCHAR(3)      collate 'en-ci' COMMENT 'Sonderhauptbuch Kennzeichen, momentan noch nicht befuellt.',
   summe_soll                          NUMBER(29,4)    COMMENT 'Sollseite des Debitorkontos',
   summe_haben                         NUMBER(29,4)    COMMENT 'Habenseite des Debitorkontos',
   saldo_vortrag                       NUMBER(29,4)    COMMENT 'Saldo Vortrag (Saldo zu Beginn der Periode), Saldo_Vortrag = Saldo Soll (Vorperiode) - Saldo Haben (Vorperiode)',
   saldo_soll                          NUMBER(29,4)    COMMENT 'Kontosaldo Sollseite',
   saldo_haben                         NUMBER(29,4)    COMMENT 'Kontosaldo Habenseite',
   saldo_konto                         NUMBER(29,4)    COMMENT 'Gesamtsaldo des Kontos (Saldo Soll - Saldo Haben)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'IVS - Kontostand des Debitors';