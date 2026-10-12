--==============================================================
-- Table: cos_bonuspunkte_xtra
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_xtra
   generated from Powerdesigner on Montag, 24. November 2025 17:42:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.COS_BONUSPUNKTE_XTRA (
   crm_konto_id                        VARCHAR(144)     NOT NULL COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos.',
   crm_kunde_id                        VARCHAR(36)      COMMENT 'CRM-interne ID des Kunden',
   crm_cidaas_id                       VARCHAR(120)     NOT NULL DEFAULT '-9999' COMMENT 'MS Dynamics - contact.kl_keycloakid -
            Meldet sich Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'KFL-Land des Kundenkontos, das an Loyalty-Programms teilnimmt.',
   anz_bonuspunkte                     INTEGER     COMMENT 'Die gesamte anzahl an Bonuspunkten auf das Konto.',
   anz_bonuspunkte_blockiert           INTEGER     COMMENT 'Die gesamte Anzahl der blockierten Bonuspunkten auf das Konto.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSPUNKTE_XTRA PRIMARY KEY (crm_konto_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle wird UAPC zur Verfügung gestellt, für die Berechnung des neuen Punktewerts eines Kontos.Die neue Regel besagt, dass für jeden ausgegebenen Euro ein Punkt gutgeschrieben wird. Diese Werte werden an das Quellsystem COSMOS DB wiedersgepiegelt.';
