CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ais_mandant_wup_2 (mandant_id OPTIONS(description='Mandant_2'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) - hier der Empfänger der der Daten z.Bsp. GfK'), wup_id
OPTIONS(description='Marktnummer'), stat_bundesamt_wup_id
OPTIONS(description='Einer Filiale (wup_id) zugeordneten ID des statistischen Bundesamtes (offiziele Berichtseinheit ID des statistischen Bundesamtes). Pflege der ID erfolg durch den KFL EK Fachbereich. '))
OPTIONS(DESCRIPTION = `AIS - TRANSAKTIONSTABELLE, DIENT DER FILTERUNG AUF FILIALEBENE FÜR DATENLIEFERUNGEN IM AIS UMFELD - WIRD ÜBER FRONTEND BEFÜLLT `)
AS SELECT mandant_id,
 gp_id,
 wup_id,
 stat_bundesamt_wup_id
FROM kfl_production_dbp_msi_data.ais_mandant_wup_2;