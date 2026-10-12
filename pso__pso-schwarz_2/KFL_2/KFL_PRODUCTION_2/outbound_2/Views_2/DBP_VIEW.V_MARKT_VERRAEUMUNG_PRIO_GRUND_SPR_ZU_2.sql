CREATE OR REPLACE VIEW kfl_production_dbp_view.v_markt_verraeumung_prio_grund_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), verraeumung_prio_grund_id
OPTIONS(description='ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'), spr_id
OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'), verraeumung_prio_grund_bez
OPTIONS(description='Sprachabhängige Bezeichnung des Verräumungs Prio Grund.'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNG DER VERRÄUMUNGS PRIO GRÜNDEN IN DER FILIALE. QUELLE: SAP ZRS_LGBPRF_CUST`)
AS SELECT mandant_id,
 verraeumung_prio_grund_id,
 spr_id,
 verraeumung_prio_grund_bez
FROM kfl_production_dbp_data.markt_verraeumung_prio_grund_spr_zu_2;