CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_crossdocking (mandant_id OPTIONS(description='Mandant im DWH.'),
crossdocking_id OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'))
OPTIONS(DESCRIPTION = `LOOKUPTABELLE FÜR DEN KAUFLAND DEFINIERTEN UMSCHLAGPLATZ BZW. CROSS-DOCKING-ORT,AN DEN DIE WAREN ZUERST VOM LIEFERANTEN VERSENDET WERDEN. AM CROSS-DOCKING-ORT ERFOLGT DANN DIE VERTEILUNG AUF DIE LÄNDER (VZ/MÄRKTE).`)
AS SELECT mandant_id,
 crossdocking_id
FROM kfl_production_dbp_data.l_crossdocking;