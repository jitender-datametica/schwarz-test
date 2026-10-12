CREATE OR REPLACE VIEW DBP_VIEW.V_L_BONUSPUNKTE_HERKUNFT_2 (
   bonuspunkte_herkunft_id                  COMMENT 'Code für die Herkunft der Punkte.'
  ,bonuspunkte_herkunft_bez                 COMMENT 'Bezeichnung für die Herkunft der Punkte.'
)
COMMENT = 'Lookup-Tabelle für die Herkunft der Bonuspunkte-Wie sie vergeben wurden.ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..'
 AS 
    SELECT 
        bonuspunkte_herkunft_id,
        bonuspunkte_herkunft_bez

FROM DBP_DATA.L_BONUSPUNKTE_HERKUNFT_2 ;