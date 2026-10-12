CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_promotion_event_zu (mandant_id
OPTIONS(description='Mandant im DWH'), angebot_nr
OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), promotion_event_id
OPTIONS(description='ID des Promotion Events.'))
OPTIONS(DESCRIPTION = `BEZIEHUNGSTABELLE ZWISCHEN DEM PROMOTION EVENT UND DEN ANGEBOTEN. EIN ANGEBOT KANN EINEM ODER MEHREREN PROMOTION EVENTS ZUGEORDNET SEIN. EIN PROMOTION EVENT BESTEHT AUS EINEM ODER MEHREREN ANGEBOTEN.`)
AS SELECT mandant_id,
 angebot_nr,
 promotion_event_id
FROM kfl_production_dbp_data.angebot_promotion_event_zu;