--==============================================================
-- Table: l_verrechfall_kostenart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verrechfall_kostenart_1
   generated from Powerdesigner on Donnerstag, 22. April 2021 10:48:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.l_verrechfall_kostenart_1 (
   mandant_id                          INTEGER          NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   verrechfall_kostenart_id            VARCHAR(10)     collate 'en-ci' NOT NULL COMMENT 'Eindeutige Kennzeichnung der Verrechnungsfallksoten (z. B. Frachtkosten, Dieselzuschlag, Umlagerung_1)',
   verrechfall_kostentyp_id            VARCHAR(1)      collate 'en-ci' COMMENT 'Typ: (F)ix oder (V)ariabel',
   verrechnungsart_id                  VARCHAR(1)      collate 'en-ci' COMMENT 'Verrechnung: (A)utomatisch oder (M)anuell'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'LIS - Kennzeichnet die Art_1 der Kosten (z. B. Abholung, Frachtpauschale, usw.)';
