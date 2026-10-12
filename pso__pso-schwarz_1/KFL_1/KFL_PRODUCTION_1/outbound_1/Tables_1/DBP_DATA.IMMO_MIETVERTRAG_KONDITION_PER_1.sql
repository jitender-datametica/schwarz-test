--==============================================================
-- Table: immo_mietvertrag_kondition_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_kondition_per_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mietvertrag_kondition_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mv_intreno STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
mo_intreno STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem die Kondition gilt'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Konditionsart'),
dat_bis DATE NOT NULL OPTIONS(description='Datum, bis zu dem die Kondition gilt'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
miete_per_anno NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Vereinbarte jährliche Miete'),
miete_umsatz_prozent NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Angabe Prozentsatz der Umsatzmiete'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='IMMO - Mietvertrag Kondition - SAP REFX - ZBI_RE_DATA_CN_CONDITION_VICNCN');