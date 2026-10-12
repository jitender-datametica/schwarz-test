--==============================================================
-- Table: cos_bonuspunkte_xtra_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_xtra_2
   generated from Powerdesigner on Montag, 24. November 2025 17:42:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.cos_bonuspunkte_xtra_2 (
crm_konto_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos.'),
crm_kunde_id STRING(36) OPTIONS(description='CRM-interne ID des Kunden'),
crm_cidaas_id STRING(120) DEFAULT '-9999' NOT NULL
OPTIONS(description='MS Dynamics - contact.kl_keycloakid -            Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  '),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='KFL-Land_2 des Kundenkontos, das an Loyalty-Programms teilnimmt.'),
anz_bonuspunkte BIGNUMERIC(38,0) OPTIONS(description='Die gesamte anzahl an Bonuspunkten auf das Konto.'),
anz_bonuspunkte_blockiert BIGNUMERIC(38,0)
OPTIONS(description='Die gesamte Anzahl der blockierten Bonuspunkten auf das Konto.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_konto_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle wird UAPC zur Verfügung gestellt, für die Berechnung des neuen Punktewerts eines Kontos.Die neue Regel besagt, dass für jeden ausgegebenen Euro ein Punkt gutgeschrieben wird. Diese Werte werden an das Quellsystem COSMOS DB wiedersgepiegelt.');