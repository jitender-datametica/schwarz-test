--==============================================================
-- Table: l_crossdocking
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_crossdocking
   generated from Powerdesigner on Freitag, 28. März 2025 12:20:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_crossdocking (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
crossdocking_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, crossdocking_id) NOT ENFORCED
)
OPTIONS(description='Lookuptabelle für den Kaufland definierten Umschlagplatz bzw. Cross-Docking-Ort,an den die Waren zuerst vom Lieferanten versendet werden. Am Cross-Docking-Ort erfolgt dann die Verteilung auf die Länder (VZ/Märkte).');