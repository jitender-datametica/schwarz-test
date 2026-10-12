--==============================================================
-- Table: els_leergut_position_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: els_leergut_position_2
   generated from Powerdesigner on Freitag, 23. September 2022 16:03:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.els_leergut_position_2 (
barcode_leergut STRING(100) NOT NULL OPTIONS(description='Barcode des Leergut-Bons'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
bon_zeile BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zeilennummer - Kommt nicht aus Quelle'),
mwst_id BIGNUMERIC(38,0) OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
kl_art_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kaufland-Artikelnummer, sofern vorhanden'),
menge BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Menge der Artikel_2'),
bon_zeilen_wert BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Wert der Bonzeile'),
plu_gruppe STRING(20) OPTIONS(description='PLU Gruppe. Z.Bsp.: 100 = Mehrweg 19 %'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (barcode_leergut, bon_zeile, mandant_id) NOT ENFORCED
)
OPTIONS(description='ELS - Positionsdaten von den am Pfandautomaten erstellten Leergutbons. Daten werden über SIB, SOLACE in Queue bereitgestellt.');