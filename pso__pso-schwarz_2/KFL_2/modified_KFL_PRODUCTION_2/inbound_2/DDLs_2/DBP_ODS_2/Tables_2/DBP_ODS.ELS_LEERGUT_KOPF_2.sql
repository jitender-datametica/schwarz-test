--==============================================================
-- Table: els_leergut_kopf_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: els_leergut_kopf_2
   generated from Powerdesigner on Freitag, 23. September 2022 16:03:05
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ELS_LEERGUT_KOPF_2 (
   barcode_leergut                     VARCHAR(100)    NOT NULL COMMENT 'Barcode des Leergut-Bons',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land_2',
   wup_id                              INTEGER    NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   bon_dat                             DATE            NOT NULL COMMENT 'Datum des Pfandbons (End-Datum bei Bon-Erstellung)',
   wrg_id                              VARCHAR(3)      NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   bon_tmsp                            TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel des Pfandbons (End-Zeitstempel bei Bon-Erstellung)',
   bon_nr                              INTEGER    COMMENT 'Bon Nummer',
   system_bez                          VARCHAR(100)    COMMENT 'System Software, mit welcher der Pfandbon erstellt wurde',
   system_typ_bez                      VARCHAR(100)    COMMENT 'Technischer Typ-Name des Systems',
   system_hersteller_bez               VARCHAR(100)    COMMENT 'Hersteller des Pfandautomaten, z.Bsp.: Tomra',
   bon_wert                            NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Wert des gesamten Bons',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ELS_LEERGUT_KOPF PRIMARY KEY (barcode_leergut, mandant_id) NOT ENFORCED
)  COMMENT = 'ELS - Kopfdaten von den am Pfandautomaten erstellten Leergutbons. Daten werden über SIB, SOLACE in Queue bereitgestellt.';
