--==============================================================
-- Table: ts_ais_de_prognose_umsatz_monat
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_prognose_umsatz_monat
   generated from Powerdesigner on Wednesday, 15 May 2024 20:19:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW2.TS_AIS_DE_PROGNOSE_UMSATZ_MONAT (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   kjmo_prognose                       INTEGER     NOT NULL COMMENT 'Monat für den die Prognose erstellt wurde.',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
   betrag_umsatz_prognose_bestandsmaerkte NUMBER(29,2)     NOT NULL COMMENT 'Umsatzprognose für alle Filialen, ausgenommen der Real2021-Übernahmefilialen.',
   betrag_umsatz_prognose_realmaerkte  NUMBER(29,2)     NOT NULL COMMENT 'Umsatzprognose für Filialen, welche Teil der Real2021 Übernahme waren.',
   betrag_wa_kalk_prognose_bestandsmaerkte NUMBER(29,2)     NOT NULL COMMENT 'WA-Kalk. nach PV Prognose für alle Filialen, ausgenommen der Real2021-Übernahmefilialen.',
   betrag_wa_kalk_prognose_realmaerkte NUMBER(29,2)     NOT NULL COMMENT 'WA-Kalk. nach PV Prognose für Filialen, welche Teil der Real2021-Übernahme waren.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AIS_DE_PROGNOSE_UMSATZ_MONAT PRIMARY KEY (mandant_id, kjmo_prognose, abt_id) NOT ENFORCED
)  COMMENT = 'AIS-DE - Monatsprognose Umsatz und WA Kalk. nach PV für EKCO DE Dossiers.';
