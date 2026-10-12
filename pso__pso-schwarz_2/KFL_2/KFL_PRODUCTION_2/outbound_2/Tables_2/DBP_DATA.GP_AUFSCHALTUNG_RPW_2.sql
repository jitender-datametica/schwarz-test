--==============================================================
-- Table: gp_aufschaltung_rpw_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_aufschaltung_rpw_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_aufschaltung_rpw_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
hgp_id BIGNUMERIC(38,0)
OPTIONS(description='Nummer des Hauptlieferanten(Kreditors) zu einem Unterlieferanten, i.d.R. die ersten 6 Stellen der siebenstelligen Lieferantennummer'),
dat_aufschaltung DATE NOT NULL OPTIONS(description='Datum , ab dem ein Lieferant in SAP RPW abgewickelt wird'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
) OPTIONS(description='RPW - DATA - Aufschaltdatum der Lieferanten im Projekt RPW');