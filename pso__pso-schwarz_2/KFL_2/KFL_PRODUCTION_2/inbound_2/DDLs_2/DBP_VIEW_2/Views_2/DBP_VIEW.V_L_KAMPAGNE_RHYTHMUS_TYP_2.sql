CREATE OR REPLACE VIEW DBP_VIEW.V_L_KAMPAGNE_RHYTHMUS_TYP_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,kampagne_rhythmus_typ_id                 COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_2, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'
)
COMMENT = 'Die Tabelle dient zur Kategorisierung und Klassifizierung verschiedener Arten von Rhythmen, die den Start einer Kampagne_2 auslösen können.'
 AS 
    SELECT 
        mandant_id,
        kampagne_rhythmus_typ_id

FROM DBP_DATA.L_KAMPAGNE_RHYTHMUS_TYP_2 ;