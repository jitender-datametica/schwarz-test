--==============================================================
-- Table: flw_besch_faktura_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_faktura_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_besch_faktura_1 (
faktura_beleg_id INTEGER NOT NULL OPTIONS(description='Faktura Belegnummer aus vbeln'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
dat_faktura DATE NOT NULL OPTIONS(description='Fakturadatum aus SAP fkdat'),
dat_erstellung DATE NOT NULL OPTIONS(description='Erstellungsdatum aus erdat'),
fakturaart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Fakturaart aus fkart'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
faktura_status_kz STRING(1) COLLATE 'und:ci' DEFAULT '0' NOT NULL
OPTIONS(description='Buchhaltungsstatus des Fakturabelegs aus der SAP Quelle VBRK.RFBSK (z.B.  E, D, A, B, C ; Defaultwert 0)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (faktura_beleg_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Fakturabelege Kopfdaten aus der SAP-Tabelle vbrk');