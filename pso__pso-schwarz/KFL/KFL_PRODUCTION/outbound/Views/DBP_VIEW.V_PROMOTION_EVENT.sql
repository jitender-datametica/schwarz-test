CREATE OR REPLACE VIEW kfl_production_dbp_view.v_promotion_event (mandant_id OPTIONS(description='Mandant im DWH'),
promotion_event_id OPTIONS(description='ID des Promotion Events.'), dat_promotion_event_gueltig_von
OPTIONS(description='Datum, ab dem das Promotion Event gültig ist.'), dat_promotion_event_gueltig_bis
OPTIONS(description='Datum, bis das Promotion Event gültig ist.'), werbemittel_id
OPTIONS(description='ID des Werbemittels'), werbemittelkanal_id OPTIONS(description='ID des Werbemittelkanals'),
werbethema_id OPTIONS(description='ID des Werbethemas'), werbeflaechenthema_cd
OPTIONS(description='Code des Werbeflaechenthemas'))
OPTIONS(DESCRIPTION = `TABELLE ENTHÄLT STAMMDATEN ZUM PROMOTION EVENT. EIN PROMOTION EVENT KANN MEHRERE ANGEBOTE ZU EINER WERBUNG ÜBER EINEM WERBEMITTEL ZUSAMMENFASSEN.`)
AS SELECT mandant_id,
 promotion_event_id,
 dat_promotion_event_gueltig_von,
 dat_promotion_event_gueltig_bis,
 werbemittel_id,
 werbemittelkanal_id,
 werbethema_id,
 werbeflaechenthema_cd
FROM kfl_production_dbp_data.promotion_event;