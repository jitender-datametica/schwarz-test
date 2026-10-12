CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_COS_BONUSPUNKTE_XTRA_1 (
   crm_konto_id                             COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos.'
  ,crm_kunde_id                             COMMENT 'CRM-interne ID des Kunden'
  ,crm_cidaas_id                            COMMENT 'MS Dynamics - contact.kl_keycloakid -
Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  '
  ,mandant_id                               COMMENT 'KFL-Land_1 des Kundenkontos, das an Loyalty-Programms teilnimmt.'
  ,anz_bonuspunkte                          COMMENT 'Die gesamte anzahl an Bonuspunkten auf das Konto.'
  ,anz_bonuspunkte_blockiert                COMMENT 'Die gesamte Anzahl der blockierten Bonuspunkten auf das Konto.'
)
COMMENT = 'Diese Tabelle wird UAPC zur Verfügung gestellt, für die Berechnung des neuen Punktewerts eines Kontos.Die neue Regel besagt, dass für jeden ausgegebenen Euro ein Punkt gutgeschrieben wird. Diese Werte werden an das Quellsystem COSMOS DB wiedersgepiegelt.
'
 AS 
    SELECT 
        crm_konto_id,
        crm_kunde_id,
        crm_cidaas_id,
        mandant_id,
        anz_bonuspunkte,
        anz_bonuspunkte_blockiert

FROM DBP_MSI_DATA.COS_BONUSPUNKTE_XTRA_1 ;