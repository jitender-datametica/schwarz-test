--==============================================================
-- Table: l_verrechfall_kostenart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verrechfall_kostenart_2
   generated from Powerdesigner on Donnerstag, 22. April 2021 10:48:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_verrechfall_kostenart_2 (
mandant_id BIGNUMERIC NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
verrechfall_kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung der Verrechnungsfallksoten (z. B. Frachtkosten, Dieselzuschlag, Umlagerung_2)'),
verrechfall_kostentyp_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Typ: (F)ix oder (V)ariabel'),
verrechnungsart_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Verrechnung: (A)utomatisch oder (M)anuell'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='LIS - Kennzeichnet die Art_2 der Kosten (z. B. Abholung, Frachtpauschale, usw.)');