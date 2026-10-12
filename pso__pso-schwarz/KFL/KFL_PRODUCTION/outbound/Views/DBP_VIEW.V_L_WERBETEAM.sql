CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeteam (mandant_id OPTIONS(description='Mandant im DWH'),
werbeteam_cd OPTIONS(description='Code des Werbeteams'), werbebereich_cd OPTIONS(description='Code des Werbebereichs'),
werbeteam_bez OPTIONS(description='Werbeteam - Bezeichnung'))
OPTIONS(DESCRIPTION = `FACHLICH VERANTWORTLICHE PERSONEN (AUCH PLANER GENANNT) DIE FÜR EINE KATEGORIE AN ARTIKEL DIE ÜBER DIE WGS IDENTIFZIERT WERDEN, DIE WERBUNGEN IN DEUTSCHLAND PLANEN.`)
AS SELECT mandant_id,
 werbeteam_cd,
 werbebereich_cd,
 werbeteam_bez
FROM kfl_production_dbp_data.l_werbeteam;