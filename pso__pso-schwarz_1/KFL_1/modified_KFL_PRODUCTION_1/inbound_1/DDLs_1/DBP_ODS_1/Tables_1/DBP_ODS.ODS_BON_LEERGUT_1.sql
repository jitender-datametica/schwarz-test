--==============================================================
-- Table: ods_bon_leergut_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_leergut_1
   generated from Powerdesigner on Dienstag, 2. August 2022 15:58:23
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_LEERGUT_1 CLUSTER BY (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
)(
   bon_id                              VARCHAR(100)    NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   bon_zeile                           INTEGER    NOT NULL COMMENT 'Die Zeile des Bons',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   bon_dat                             DATE            NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   ean_kasse                           NUMBER(29,0)    COMMENT 'Hier ist der Barcode des Leergutbons hinterlegt',
   umsatz_brutto                       NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Umsatz Brutto Betrag',
   start_bon_zeile                     TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
   bon_nr_extern                       INTEGER    COMMENT 'Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten',
   kpos_erfassung_id                   VARCHAR(40)     COMMENT 'Erfassungsart: Manuell, Scan, etc.',
   menge                               INTEGER    DEFAULT 0 NOT NULL COMMENT 'Menge / Anzahl an Leergut',
   kl_art_id                           INTEGER    COMMENT 'Kaufland Artikelnummer',
   einh_id                             VARCHAR(12)     COMMENT 'Einheit: Stueck, Kiste, etc.',
   mwst_id                             INTEGER    DEFAULT 0 NOT NULL COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
   barcode_leergut                     VARCHAR(100)    COMMENT 'Barcode des Pfandzettels',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_LEERGUT PRIMARY KEY (bon_id, bon_dat, mandant_id, wup_id, bon_zeile) NOT ENFORCED
)  COMMENT = 'ODS -Leergutbons aus den Bonzeilen. Redundant gespeichert zur Steigerung der Performance. Alternativ wäre_1 Join Index denkbar';
