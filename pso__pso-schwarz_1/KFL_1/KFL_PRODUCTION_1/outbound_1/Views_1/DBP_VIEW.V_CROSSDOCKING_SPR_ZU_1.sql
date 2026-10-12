CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crossdocking_spr_zu_1 (mandant_id OPTIONS(description='Mandant_1 im DWH.'),
crossdocking_id OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'), spr_id
OPTIONS(description='ID der Sprache. Referenz zu der Tabelle spr.'), crossdocking_bez
OPTIONS(description='Sprachabhängig Kurzbezeichnung des Umschlagplatzs bzw. Cross-Docking-Orts. Bsp "Wien Plattform" -  Lieferanten im Frische Bereich liefert an die Wien Plattform. Diese verteilt die Lieferung auf die Länder (VZ/Märkte). Weitere Cross Docking Orte sind noch nicht bekannt.(Stand: 24.03.2025)'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNGEN DES CROSS DOCKING ORTS.`) AS SELECT mandant_id,
 crossdocking_id,
 spr_id,
 crossdocking_bez
FROM kfl_production_dbp_data.crossdocking_spr_zu_1;