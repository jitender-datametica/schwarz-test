CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_COS_BONUSPUNKTE_TAG_2 (
   crm_konto_id                             COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos.'
  ,dat                                      COMMENT 'Datum für Tagesstand der Bonuspunkte.'
  ,bonuspunkte_kanal_id                     COMMENT 'Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.'
  ,mandant_id                               COMMENT 'KFL-Land_2 des Kundenkontos, das an Loyalty-Programms teilnimmt.'
  ,anz_bonuspunkte                          COMMENT 'Die tägliche gesamte anzahl an Bonuspunkten auf das Konto.'
)
COMMENT = 'Die Tabelle enthält die täglichen Bonuspunkten eines Kunden.
'
 AS 
    SELECT 
        crm_konto_id,
        dat,
        bonuspunkte_kanal_id,
        mandant_id,
        anz_bonuspunkte

FROM DBP_MSI_DATA.COS_BONUSPUNKTE_TAG_2 ;