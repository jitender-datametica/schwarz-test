CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bonuspunkte_kanal (bonuspunkte_kanal_id
OPTIONS(description='ID der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.'), bonuspunkte_kanal_bez
OPTIONS(description='Bezeichnung der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE PLATTFORM WO DIE BONUSPUNKTE ERWORBEN ODER AUSGEGEBEN WURDEN.ZB: MARKPLATZ, FILIALE.`)
AS SELECT bonuspunkte_kanal_id,
 bonuspunkte_kanal_bez
FROM kfl_production_dbp_data.l_bonuspunkte_kanal;