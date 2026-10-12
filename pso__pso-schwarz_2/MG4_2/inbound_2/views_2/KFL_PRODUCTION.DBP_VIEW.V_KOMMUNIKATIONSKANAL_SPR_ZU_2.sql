create or replace view KFL_PRODUCTION.DBP_VIEW.V_KOMMUNIKATIONSKANAL_SPR_ZU_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	KOMMUNIKATIONSKANAL_ID COMMENT 'Eindeutige Kennung des Kommunikationskanals',
	SPR_ID COMMENT 'ID der DWH-Sprache, z.B. 22 ist Deutsch',
	KOMMUNIKATIONSKANAL_BEZ COMMENT 'Übersetzung des Kanalnamens oder der Kanalbeschreibung in die jeweilige Sprache, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS'
) COMMENT='Sprachabhängige Bezeichnungen der Kommunikationskanäle für Marketingkampagnen - manuell versorgt'
 as 
    SELECT 
        mandant_id,
        kommunikationskanal_id,
        spr_id,
        kommunikationskanal_bez

FROM DBP_DATA.KOMMUNIKATIONSKANAL_SPR_ZU_2 ;