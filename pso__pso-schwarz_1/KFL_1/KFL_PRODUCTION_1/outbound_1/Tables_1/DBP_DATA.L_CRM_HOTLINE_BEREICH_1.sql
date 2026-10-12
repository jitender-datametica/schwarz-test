--==============================================================
-- Table: l_crm_hotline_bereich_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_crm_hotline_bereich_1
   generated from Powerdesigner on Dienstag, 20. Mai 2025 16:10:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_crm_hotline_bereich_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
crm_hotline_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, crm_hotline_bereich_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle ist eine_1 Lookup-Tabelle für die Bereiche bzw. Abteilungen der CRM-Hotline. Sie enthält eine_1 Liste der Bereiche, an die Anrufe zugestellt werden und die Anrufe entgegennehmen, z.B. KCard, Kundenhotline, Schadenshotline oder Zentrale.Sie wird manuell befüllt.');