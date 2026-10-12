--==============================================================
-- Table: flw_rohertrag_plan_ist_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_rohertrag_plan_ist_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_rohertrag_plan_ist_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
buchungsperiode_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Buchungsperiode innerhalb des Geschäftsjahres (z.B. 01 = März, 02 = April für DE, bis 16)'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
plan_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnung ob es sich um Plan oder Ist Zahlen handelt (0 = Ist Zahlen, 1 = Plan Zahlen)'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
rohertrag_betrag NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Rohertragswert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, buchungsperiode_id, plan_fg, werk_id, gj, mandant_id) NOT ENFORCED
)
OPTIONS(description='FLW - Ist / Planwerte für Fleischwaren pro Artikel_1,  Periode und Vertriebsweg. Quelle ist Hyperion HFM');