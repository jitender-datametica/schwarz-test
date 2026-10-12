--==============================================================
-- Table: cos_bonuspunkte_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_tag_1
   generated from Powerdesigner on Montag, 24. November 2025 17:42:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.cos_bonuspunkte_tag_1 (
crm_konto_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos.'),
dat DATE NOT NULL OPTIONS(description='Datum für Tagesstand der Bonuspunkte.'),
bonuspunkte_kanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='KFL-Land_1 des Kundenkontos, das an Loyalty-Programms teilnimmt.'),
anz_bonuspunkte BIGNUMERIC(38,0) OPTIONS(description='Die tägliche gesamte anzahl an Bonuspunkten auf das Konto.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_konto_id, dat, bonuspunkte_kanal_id) NOT ENFORCED
) OPTIONS(description='Die Tabelle enthält die täglichen Bonuspunkten eines Kunden.');