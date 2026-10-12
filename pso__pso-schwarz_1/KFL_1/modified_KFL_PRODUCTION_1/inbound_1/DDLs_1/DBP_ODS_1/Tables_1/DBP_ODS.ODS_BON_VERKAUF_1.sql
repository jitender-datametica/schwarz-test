--==============================================================
-- Table: ods_bon_verkauf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_verkauf_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 14:36:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_VERKAUF_1 CLUSTER BY (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
) (
   bon_id                              VARCHAR(100)     NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert',
   bon_zeile                           INTEGER     NOT NULL COMMENT 'Bonzeile des Kassenbons',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   kl_art_id                           INTEGER     COMMENT 'Kaufland Artikelnummer',
   ean_kasse                           NUMBER(29,0)     COMMENT 'Die EAN_1 des Artikels',
   wg_id                               INTEGER     COMMENT 'Die Warengruppe aus der Kasse',
   menge                               NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge der Position.',
   einh_id                             VARCHAR(12)      COMMENT 'Einheit. Nur gefuellt bei Gewichtsware, sonst NULL',
   umsatz_brutto                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
   mwst_id                             INTEGER     NOT NULL COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
   erfassung_id                        VARCHAR(40)      COMMENT 'Gibt an, ob gescannt oder haendisch eingegeben',
   aktion_id                           VARCHAR(80)      NOT NULL COMMENT 'ID der Verkaufsaktion. Wird nicht gegen die Stammdaten geprueft',
   talon_id                            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'ID des Waagentalons. Nur gefuellt, wenn sich die Position auf einen Talon bezieht.',
   start_bon_zeile                     TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
   bon_nr_extern                       INTEGER     COMMENT 'Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten',
   kpos_erfassung_id                   VARCHAR(2040)    COMMENT 'Erfassungsart: Manuell, Scan, etc.',
   umsatz_brutto_norm                  NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT ' Normaler Verkaufswert (Verkaufswert=Menge*Normalpreis;  Rabatte nicht abgezogen!)',
   vk_brutto_obb                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Tatsaechlicher Verkaufspreis des Artikels pro Einheit inkl. Preisreduzierung, ohne Bonus Buy',
   bon_vorgang_id                      INTEGER     NOT NULL DEFAULT -1 COMMENT 'Geschaeftsvorfallunterscheidung (K-POS) (0 = Sonstiges, 1 = E_LOADING_ARTICLE, 2 = OTHER_MONEY_EXCHANGE, 3 = iTUNES, 4 = EXTERNAL_GIFTCARD, 5 = CONCESSIONAL, 6 = PAY_ON_SCAN)',
   barcode_string                      VARCHAR(400)     COMMENT 'Barcode des Kassenbons',
   barcode_leergut                     VARCHAR(100)     COMMENT 'Barcode des Pfandbons',
   zeilenstorno_fg                     INTEGER     NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet einen Zeilenstorno, fg = 1 Zeilenstorno liegt vor, fg = 0 Kein Zeilenstorno.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_VERKAUF PRIMARY KEY (bon_id, bon_dat, mandant_id, wup_id, bon_zeile) NOT ENFORCED
)  COMMENT = 'ODS - Aus den Kassensystemen near Realtime geladene Bon-Zeilen';