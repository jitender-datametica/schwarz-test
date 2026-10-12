--==============================================================
-- Table: els_leergut_position
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: els_leergut_position
   generated from Powerdesigner on Freitag, 23. September 2022 16:03:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ELS_LEERGUT_POSITION (
   barcode_leergut                     VARCHAR(100)    NOT NULL COMMENT 'Barcode des Leergut-Bons',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
   bon_zeile                           INTEGER    NOT NULL COMMENT 'Zeilennummer - Kommt nicht aus Quelle',
   mwst_id                             INTEGER    COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
   wrg_id                              VARCHAR(3)      NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   kl_art_id                           INTEGER    DEFAULT 0 NOT NULL COMMENT 'Kaufland-Artikelnummer, sofern vorhanden',
   menge                               INTEGER    NOT NULL COMMENT 'Menge der Artikel',
   bon_zeilen_wert                     NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Wert der Bonzeile',
   plu_gruppe                          VARCHAR(20)     COMMENT 'PLU Gruppe. Z.Bsp.: 100 = Mehrweg 19 %',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ELS_LEERGUT_POSITION PRIMARY KEY (barcode_leergut, bon_zeile, mandant_id) NOT ENFORCED
)  COMMENT = 'ELS - Positionsdaten von den am Pfandautomaten erstellten Leergutbons. Daten werden über SIB, SOLACE in Queue bereitgestellt.';
