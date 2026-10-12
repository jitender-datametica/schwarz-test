CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kampagne_rhythmus_typ_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), kampagne_rhythmus_typ_id
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne_2, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.'))
OPTIONS(DESCRIPTION = `DIE TABELLE DIENT ZUR KATEGORISIERUNG UND KLASSIFIZIERUNG VERSCHIEDENER ARTEN VON RHYTHMEN, DIE DEN START EINER KAMPAGNE_2 AUSLÖSEN KÖNNEN.`)
AS SELECT mandant_id,
 kampagne_rhythmus_typ_id
FROM kfl_production_dbp_data.l_kampagne_rhythmus_typ_2;