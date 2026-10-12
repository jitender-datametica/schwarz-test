CREATE OR REPLACE VIEW DBP_VIEW.V_L_BONUSPUNKTE_KANAL_1 (
   bonuspunkte_kanal_id                     COMMENT 'ID der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.'
  ,bonuspunkte_kanal_bez                    COMMENT 'Bezeichnung der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.'
)
COMMENT = 'Lookup-Tabelle für die Plattform wo die Bonuspunkte erworben oder ausgegeben wurden.ZB: Markplatz, Filiale.'
 AS 
    SELECT 
        bonuspunkte_kanal_id,
        bonuspunkte_kanal_bez

FROM DBP_DATA.L_BONUSPUNKTE_KANAL_1 ;