--==============================================================
-- Table: gp_buchungskreis_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_buchungskreis_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_buchungskreis_zu (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
zahlsperre_id STRING(1)
OPTIONS(description='Eindeutiger Schluessel fuer eine Zahlsperre eines Lieferanten. Referenz zu der Tabelle l_zahlsperre;'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, gp_id, einkaufsorganisation_id, buchungskreis_id, mandant_id) NOT ENFORCED
) OPTIONS(description='RPW - Buchungkreisabhängige Informationen zum Lieferanten aus der SAP Tabelle LFB1.');