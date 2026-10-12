CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_nachricht_aktion_typ_spr_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), nachricht_aktion_typ_id
OPTIONS(description='ID, die die Art_1 der ausgeführten Aktion_1 angibt.'), spr_id
OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'), nachricht_aktion_typ_bez
OPTIONS(description='Bezeichnung des Absendungaktionen in unterschiedlichen Sprachen, z. B. Gesendet, Blockiert, Zugestellt, Bounced, Geöffnet, Feedback Loop, Link geklicked, usw.'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNGEN DER AKTIONSTYPEN FÜR MARKETINGKAMPAGNEN - MANUELL VERSORGT.`) AS
SELECT mandant_id,
 nachricht_aktion_typ_id,
 spr_id,
 nachricht_aktion_typ_bez
FROM kfl_production_dbp_data.kampagne_nachricht_aktion_typ_spr_zu_1;