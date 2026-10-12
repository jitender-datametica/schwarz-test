--==============================================================
-- Table: ts_ais_de_prognose_umsatz_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_prognose_umsatz_tag
   generated from Powerdesigner on Wednesday, 15 May 2024 20:18:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW2.TS_AIS_DE_PROGNOSE_UMSATZ_TAG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   dat_prognose                        DATE             NOT NULL COMMENT 'Datum für den die Prognose erstellt wurde.',
   abt_id                              NUMBER(38,0)     NOT NULL COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
   betrag_umsatz_prognose_bestandsmaerkte NUMBER(38,2)     NOT NULL COMMENT 'Umsatzprognose für alle Filialen, ausgenommen der Real2021-Übernahmefilialen.',
   betrag_umsatz_prognose_realmaerkte  NUMBER(38,2)     NOT NULL COMMENT 'Umsatzprognose für Filialen, welche Teil der Real2021-Übernahme waren.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AIS_DE_PROGNOSE_UMSATZ_TAG PRIMARY KEY (mandant_id, dat_prognose, abt_id) NOT ENFORCED
)  COMMENT = 'AIS-DE - Umsatzprognose der EKCO DE Tagesreporting Dossiers.';
