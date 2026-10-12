CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_cos_bonuspunkte_xtra_1 (crm_konto_id
OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos.'), 
crm_kunde_id OPTIONS(description='CRM-interne ID des Kunden'), 
crm_cidaas_id OPTIONS(description='MS Dynamics - contact.kl_keycloakid -Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  '),
mandant_id OPTIONS(description='KFL-Land_1 des Kundenkontos, das an Loyalty-Programms teilnimmt.'), 
anz_bonuspunkte OPTIONS(description='Die gesamte anzahl an Bonuspunkten auf das Konto.'), 
anz_bonuspunkte_blockiert OPTIONS(description='Die gesamte Anzahl der blockierten Bonuspunkten auf das Konto.'))
OPTIONS(DESCRIPTION = `Diese Tabelle wird UAPC zur Verfügung gestellt, für die Berechnung des neuen Punktewerts eines Kontos.Die neue Regel besagt, dass für jeden ausgegebenen Euro ein Punkt gutgeschrieben wird. Diese Werte werden an das Quellsystem COSMOS DB wiedersgepiegelt.`)
AS SELECT crm_konto_id,
 crm_kunde_id,
 crm_cidaas_id,
 mandant_id,
 anz_bonuspunkte,
 anz_bonuspunkte_blockiert
FROM kfl_production_dbp_msi_data.cos_bonuspunkte_xtra_1;