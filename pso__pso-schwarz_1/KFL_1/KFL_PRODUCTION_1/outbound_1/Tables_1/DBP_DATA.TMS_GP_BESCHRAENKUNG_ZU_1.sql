--==============================================================
-- Table: tms_gp_beschraenkung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_gp_beschraenkung_zu_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_gp_beschraenkung_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_gp_id STRING(30) NOT NULL OPTIONS(description='ID des Geschäftspartners (Kundennummer). Aus plkd.nr'),
tms_gp_typ_cd STRING(3) NOT NULL
OPTIONS(description='Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)'),
tms_beschraenkung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftspartner-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …'),
tms_beschraenkung_pos_nr BIGNUMERIC(38,0)
OPTIONS(description='Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. bes1 = 1, bes2 = 2, …'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd, tms_beschraenkung_id) NOT ENFORCED
)
OPTIONS(description='TMS - Zuordnungstabelle für Geschäftspartner mit Einschränkungen, um die für den Geschäftspartner geltenden Einschränkungen zu definieren. Aus der Quelle plkd (WANKO)');