CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_rhythmus_typ_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), kampagne_rhythmus_typ_id
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.'), spr_id
OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'), kampagne_rhythmus_typ_bez
OPTIONS(description='Bezeichnung der Art_2 der Wiederholungshäufigkeit der Kampagne_2 in unterschiedlichen Sprachen.'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNGEN DES RHYTHMUSTYPS DER KAMPAGNE_2 - MANUELL VERSORGT.`) AS SELECT
 mandant_id,
 kampagne_rhythmus_typ_id,
 spr_id,
 kampagne_rhythmus_typ_bez
FROM kfl_production_dbp_data.kampagne_rhythmus_typ_spr_zu_2;