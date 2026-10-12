CREATE OR REPLACE VIEW DBP_VIEW.V_L_BONUSPUNKTE_GRUND_1 (
   bonuspunkte_grund_cd                     COMMENT 'Code des Grunds der Bonuspunktevergabe.'
  ,bonuspunkte_grund_bez                    COMMENT 'Bezeichnung des Grunds der Bonuspunktevergabe.'
)
COMMENT = 'Lookup-Tabelle für den Grund der Bonuspunktevergabe.Zb:checkout, cancellation, Registrierung von PDP.Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.'
 AS 
    SELECT 
        bonuspunkte_grund_cd,
        bonuspunkte_grund_bez

FROM DBP_DATA.L_BONUSPUNKTE_GRUND_1 ;