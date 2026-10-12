--==============================================================
-- Table: ods_bon_zahlung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_zahlung_1
   generated from Powerdesigner on Montag, 27. März 2023 18:09:05
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_ZAHLUNG_1 CLUSTER BY (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
) (
   bon_id                              VARCHAR(100)     NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
   bon_zeile                           INTEGER     NOT NULL COMMENT 'Die Zeile des Bons.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
   zahlung_typ_id                      INTEGER     NOT NULL COMMENT 'ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden.',
   start_bon_zeile                     TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel bei Beginn der Bewegung.',
   betrag_zahlung                      NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Der Zahlbetrag. Positiv, wenn gegeben, negativ, wenn Rückgeld.',
   wrg_id                              VARCHAR(12)      NOT NULL COMMENT 'Währung ID, z.Bsp ''EUR''.',
   kpos_zahlung_typ_id                 VARCHAR(2040)    COMMENT 'Zahlungstyp aus Kassensystem KPOS ist nicht numerisch. COMPRESS mit CAMSET.',
   bon_zeile_cashback_referenz         INTEGER     COMMENT 'Referenz zur Bon Zeile der Kartenzahlung Bon Zeile.',
   kartennummer_maskiert               VARCHAR(120)     COMMENT 'Maskierte Kartennummer. Nur die Bankengruppe ist daraus zu entnehmen.',
   barcode_leergut                     VARCHAR(100)     COMMENT 'Barcode des Pfandzettels',
   gutschein_id                        NUMBER(29,0)     COMMENT 'Eindeutige ID eines Wertgutscheins.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_ZAHLUNG PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id, bon_zeile) NOT ENFORCED
)  COMMENT = 'ODS - Aus den Kassensystemen near Realtime geladene Zahlungsinformationen (Bon-Zeilen)';
