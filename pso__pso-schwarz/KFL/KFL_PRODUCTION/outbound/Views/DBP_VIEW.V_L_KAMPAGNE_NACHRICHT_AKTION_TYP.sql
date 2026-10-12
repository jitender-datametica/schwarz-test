CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kampagne_nachricht_aktion_typ (mandant_id
OPTIONS(description='Mandant im DWH.'), nachricht_aktion_typ_id
OPTIONS(description='ID, die die Art der ausgeführten Aktion angibt, z. B. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked, etc..'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DIE REFERENZINFORMATIONEN ZU DEN VERSCHIEDENEN AKTIONSTYPEN, DIE IM ZUSAMMENHANG MIT EINER VERSENDETEN NACHRICHT AUFTRETEN KÖNNEN, Z. B. GESENDET, BLOCKIERT, ZUGESTELLT, GEÖFFNET, USW.`)
AS SELECT mandant_id,
 nachricht_aktion_typ_id
FROM kfl_production_dbp_data.l_kampagne_nachricht_aktion_typ;