CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kommunikationskanal_spr_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), kommunikationskanal_id
OPTIONS(description='Eindeutige Kennung des Kommunikationskanals'), spr_id
OPTIONS(description='ID der DWH-Sprache, z.B. 22 ist Deutsch'), kommunikationskanal_bez
OPTIONS(description='Übersetzung des Kanalnamens oder der Kanalbeschreibung in die jeweilige Sprache, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNGEN DER KOMMUNIKATIONSKANÄLE FÜR MARKETINGKAMPAGNEN - MANUELL VERSORGT`)
AS SELECT mandant_id,
 kommunikationskanal_id,
 spr_id,
 kommunikationskanal_bez
FROM kfl_production_dbp_data.kommunikationskanal_spr_zu_1;