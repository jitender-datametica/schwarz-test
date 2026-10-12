CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wup_dat_leergut_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), wup_id OPTIONS(description='Marktnummer'), nb_id
OPTIONS(description='Nebenbetriebs ID, bei Märkten immer = 0'), dat
OPTIONS(description='Datum der Zählung des Leerguts.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'), betrag_leergut_zaehlung
OPTIONS(description='Hausleiter zählt regelmäßig das Leergut und trägt dann den Wert in Landeswährung ein. Wird von Frontend (Transaction) per update/insert gepflegt.'),
betrag_leergut_inventur OPTIONS(description='Inventurwert von Leergut. Wird DWH intern aus Inventuren befüllt.'))
OPTIONS(DESCRIPTION = `DER BETRAG DES LEERGUTS IN EINER FILIALE. DIESE INFORMATION WIRD ENTWEDER DURCH EINE_2 JÄHRLICHE INVENTUR_2 ODER EINE_2 MONATLICHE ZÄHLUNG,DIE VOM HAUSLEITER DURCHGEFÜHRT WIRD,BEKANNT. WIRD PER TRANSACTION UND PER ABINITIO BEFÜLLT.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 wrg_id,
 betrag_leergut_zaehlung,
 betrag_leergut_inventur
FROM kfl_production_dbp_msi_data.ts_wup_dat_leergut_2;