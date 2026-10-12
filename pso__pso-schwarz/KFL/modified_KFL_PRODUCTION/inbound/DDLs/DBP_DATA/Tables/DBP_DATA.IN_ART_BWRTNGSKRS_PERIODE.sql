--==============================================================
-- Table: in_art_bwrtngskrs_periode
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_art_bwrtngskrs_periode
   generated from Powerdesigner on Dienstag, 13. September 2022 11:58:56
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_ART_BWRTNGSKRS_PERIODE (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   gjmo                                INTEGER    NOT NULL COMMENT 'Geschaeftsjahresmonat',
   bewertungskreis_id                  VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'der Bewertungskreis enthaelt die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  ',
   in_art_id                           INTEGER    NOT NULL COMMENT 'Im DWH erzeugter numerischer Schluessel für die Artikelnummer.',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   dat_aenderung                       DATE            NOT NULL COMMENT 'Aenderungsdatum des Satzes im SAP Quellsystem.',
   gjmo_bis                            INTEGER    NOT NULL COMMENT 'Geschaeftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei "Luecken" in den Monaten zu vereinfachen',
   mbew_fg                             INTEGER    NOT NULL COMMENT 'kenneichnet die Quelltabelle des Satzes. Wenn aus mbew, dann = 1, mbewh = 0',
   menge_bestand_bme                   NUMBER(29,3)    NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten aus lbkum',
   wert_bestand                        NUMBER(29,4)    COMMENT 'Wert des gesamten bewerteten Bestandes',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_ART_BWRTNGSKRS_PERIODE PRIMARY KEY (mandant_id, gjmo, bewertungskreis_id, in_art_id) NOT ENFORCED
)  COMMENT = 'BIS- Bestand aus den SAP Industrie Datenquellen MBEWH und MBEW - MULTISET';
