--==============================================================
-- Table: ais_mandant_wup
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ais_mandant_wup
   generated from Powerdesigner on Montag, 26. August 2024 18:10:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ais_mandant_wup (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
gp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) - hier der Empfänger der der Daten z.Bsp. GfK'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
stat_bundesamt_wup_id BIGNUMERIC(38,0)
OPTIONS(description='Einer Filiale (wup_id) zugeordneten ID des statistischen Bundesamtes (offiziele Berichtseinheit ID des statistischen Bundesamtes). Pflege der ID erfolg durch den KFL EK Fachbereich. '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id, wup_id) NOT ENFORCED
)
OPTIONS(description='AIS - Transaktionstabelle, dient der Filterung auf Filialebene für Datenlieferungen im AIS Umfeld - wird über FrontEnd befüllt ');