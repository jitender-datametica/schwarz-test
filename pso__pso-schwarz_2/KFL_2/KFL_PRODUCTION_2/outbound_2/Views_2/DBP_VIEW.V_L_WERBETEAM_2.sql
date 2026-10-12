CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeteam_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
werbeteam_cd OPTIONS(description='Code des Werbeteams'), werbebereich_cd OPTIONS(description='Code des Werbebereichs'),
werbeteam_bez OPTIONS(description='Werbeteam - Bezeichnung'))
OPTIONS(DESCRIPTION = `FACHLICH VERANTWORTLICHE PERSONEN (AUCH PLANER GENANNT) DIE FÜR EINE_2 KATEGORIE AN ARTIKEL_2 DIE ÜBER DIE WGS IDENTIFZIERT WERDEN, DIE WERBUNGEN IN DEUTSCHLAND PLANEN.`)
AS SELECT mandant_id,
 werbeteam_cd,
 werbebereich_cd,
 werbeteam_bez
FROM kfl_production_dbp_data.l_werbeteam_2;