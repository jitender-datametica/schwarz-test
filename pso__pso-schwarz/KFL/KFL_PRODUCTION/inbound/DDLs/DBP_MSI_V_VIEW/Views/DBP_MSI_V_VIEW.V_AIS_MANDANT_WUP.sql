CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_AIS_MANDANT_WUP (
   mandant_id                               COMMENT 'Mandant'
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID) - hier der Empfänger der der Daten z.Bsp. GfK'
  ,wup_id                                   COMMENT 'Marktnummer'
  ,stat_bundesamt_wup_id                    COMMENT 'Einer Filiale (wup_id) zugeordneten ID des statistischen Bundesamtes (offiziele Berichtseinheit ID des statistischen Bundesamtes). Pflege der ID erfolg durch den KFL EK Fachbereich. '
)
COMMENT = 'AIS - Transaktionstabelle, dient der Filterung auf Filialebene für Datenlieferungen im AIS Umfeld - wird über FrontEnd befüllt '
 AS 
    SELECT 
        mandant_id,
        gp_id,
        wup_id,
        stat_bundesamt_wup_id

FROM DBP_MSI_DATA.AIS_MANDANT_WUP ;