CREATE OR REPLACE VIEW DBP_VIEW.V_COS_BONUSPUNKTE_BLOCKIERT_1 (
   crm_konto_id                             COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos.'
  ,dat_bonuspunkte_blockiert_bis            COMMENT 'Datum bis wann die Bonuspunkte blockiert sind. Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.'
  ,dat_verfall_bonuspunkte_blockiert        COMMENT 'Datum, an dem die gesammelten Bonuspunkte verfallen werden.'
  ,mandant_id                               COMMENT 'KFL-Land_1 des Kundenkontos, das an Loyalty-Programms teilnimmt.'
  ,anz_bonuspunkte_blockiert                COMMENT 'Die gesamte anzahl der blockierten Bonuspunkten auf das Konto.'
  ,datzeit_update                           COMMENT 'Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.'
)
COMMENT = 'Die Tabelle enthält, die erworbenen Bonuspunkte bei Kunden, die bis zu einem Datum blockiert sind und später gutgeschrieben werden.,z.B. nach Ablauf der Rückgabefrist.'
 AS 
    SELECT 
        crm_konto_id,
        dat_bonuspunkte_blockiert_bis,
        dat_verfall_bonuspunkte_blockiert,
        mandant_id,
        anz_bonuspunkte_blockiert,
        datzeit_update

FROM DBP_DATA.COS_BONUSPUNKTE_BLOCKIERT_1 ;