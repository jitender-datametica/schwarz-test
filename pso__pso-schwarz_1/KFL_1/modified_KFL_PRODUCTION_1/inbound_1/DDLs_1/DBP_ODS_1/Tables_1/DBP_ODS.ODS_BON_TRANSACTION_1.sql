--==============================================================
-- Table: ods_bon_transaction_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_transaction_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 14:37:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_TRANSACTION_1 CLUSTER BY (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
) (
   bon_id                              VARCHAR(25)      NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   kasse_nr                            INTEGER     NOT NULL COMMENT 'Nummer der Kasse',
   bon_beginn                          TIMESTAMP_NTZ(9) COMMENT 'Start-Zeitpunkt des Bons',
   datei_name                          VARCHAR(255)     COMMENT 'Bezeichnung der Ursprungsdatei zwecks Rueckverfolgbarkeit der Daten. Mit CAMSET_L komprimieren',
   kassierer_nr                        VARCHAR(4)       COMMENT 'Nummer des Kassierers',
   cancel_fg                           INTEGER     NOT NULL COMMENT 'Das Flag kennzeichnet einen Abbruchvorgang',
   transaction_name                    VARCHAR(120)     COMMENT 'Textfeld fuer die Transaktion, wie Kassen-An-, Abmeldung',
   bon_nr                              INTEGER     NOT NULL COMMENT 'Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im normal Fall ist diese Nummer pro tag_1 und Kasse Unique)',
   bon_ende                            TIMESTAMP_NTZ(9) COMMENT 'Ende-Zeitpunkt des Bons',
   bon_booking                         TIMESTAMP_NTZ(9) COMMENT 'Buchungszeitpunkt des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war. Kann NULL sein',
   suspended_fg                        INTEGER     NOT NULL COMMENT 'Flag kennzeichnet einen Suspended-Status_1 der Transaktion. 1 = suspended',
   training_fg                         INTEGER     NOT NULL COMMENT 'Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.',
   kasse_typ_id                        INTEGER     COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
   kpos_kasse_typ                      VARCHAR(10)      COMMENT 'Im Kassensystem KPOS verwendete nicht-numerische Kassentypen',
   kassensystem_name                   VARCHAR(10)      COMMENT 'Es wird nur drei hartkodierte Auspraegungen geben! KPOS, LUCAS, POSITION',
   kpos_transaction_name               VARCHAR(255)     COMMENT 'Textfeld fuer die Transaktion speziell fuer Kassensystem KPOS, wie Kassen-An-, Abmeldung. Per CAMSET compressen',
   kpos_transaction_status             INTEGER     COMMENT 'Status_1 Kassensystem KPOS. 1 = true, 0 = false',
   dat_booking                         DATE             COMMENT 'Buchungsdatum des Bons aus businessDayDate. Redundant zu bon_booking aus Performancegruenden',
   bon_nr_fiscal                       INTEGER     COMMENT 'In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt)',
   bon_status_cd                       VARCHAR(100)     COMMENT 'Gibt den Status_1 des Bons an. Quelle: Kassen XML ReceiptState',
   bon_abbruch_grund_txt               VARCHAR(100)     COMMENT 'Gibt den Grund für einen Bonabbruch an. Quelle: Kassen XML CancelReason',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_TRANSACTION PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
)  COMMENT = 'ODS - Hier werden die An- und Abmeldungen an den Kassen hinterlegt';