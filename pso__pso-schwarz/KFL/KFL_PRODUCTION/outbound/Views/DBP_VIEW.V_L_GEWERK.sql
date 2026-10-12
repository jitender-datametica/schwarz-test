CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gewerk (mandant_id OPTIONS(description='Mandant im DWH'), gewerk_id
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), finanz_gruppe_nr
OPTIONS(description='Alphanumerische Nummer der Finanzgruppe. Jedes Gewerk besitzt genau eine dazugehörige Finanzgruppe. Über diese Nummer kann bspw. das Budget zum Projekt gemapped werden.'))
AS SELECT mandant_id,
 gewerk_id,
 finanz_gruppe_nr
FROM kfl_production_dbp_data.l_gewerk;