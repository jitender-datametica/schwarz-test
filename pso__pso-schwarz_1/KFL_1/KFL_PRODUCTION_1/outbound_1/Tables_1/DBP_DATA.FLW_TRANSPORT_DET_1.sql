--==============================================================
-- Table: flw_transport_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_transport_det_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
tour_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM'),
komm_bereich_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kommissionierbereich aus Feld KBEREICH'),
kunde_grp_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Warenempfängergruppe aus Feld WEMPFGRP'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
lkw_postyp_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Positionstyp aus Feld LKW_POSTYP'),
anz_stellplatz_ist NUMERIC(9,2) NOT NULL OPTIONS(description='Erfasste Stellplätze aus Feld ERF_SP'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (tour_id, flw_kunde_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Transport - SAP FLW (P21) - ZFW_TR_POSTYP');