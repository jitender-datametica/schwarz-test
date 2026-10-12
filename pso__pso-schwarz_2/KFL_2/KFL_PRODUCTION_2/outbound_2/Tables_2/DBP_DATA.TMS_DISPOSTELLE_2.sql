--==============================================================
-- Table: tms_dispostelle_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_dispostelle_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_dispostelle_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_dispostelle_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Dispostelles. Auspldispst.dst_id'),
tms_dispostelle_name STRING(50) NOT NULL OPTIONS(description='Dispostelle Name'),
lagernummer_id STRING(4) OPTIONS(description='Lagernummer der Dispostelle'),
bestand_tms_gp_id STRING(30)
OPTIONS(description='TMS Geschäftspartner-ID des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.'),
bestand_tms_gp_typ_cd STRING(3)
OPTIONS(description='TMS Geschäftspartnertyp-Code des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_dispostelle_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält Informationen über die Dispositionsstellen innerhalb des Unternehmens. Diese Stellen sind verantwortlich für die Planung und Steuerung von Transportprozessen. Aus der Quelle pldispst (WANKO)');