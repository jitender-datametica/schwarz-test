CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_plan (mandant_id OPTIONS(description='Mandant im DWH'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), gj
OPTIONS(description='Geschäftsjahr, Format JJJJ'), inventurart_id
OPTIONS(description='SRS: Inventurart (international nicht identisch)'), owg_id
OPTIONS(description='ID der Oberwarengruppe'), wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_vk_netto OPTIONS(description='Geplanter Umsatz je OWG und Markt'), betrag_vk_netto_inventur_diff_plan
OPTIONS(description='Geplante Inventurdifferenz je OWG, Inventurart und Markt'))
OPTIONS(DESCRIPTION = `Planwerte für Umsatz und Inventurverluste je OWG und Inventurart pro Geschäftsjahr und Markt.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 gj,
 inventurart_id,
 owg_id,
 wrg_id,
 betrag_vk_netto,
 betrag_vk_netto_inventur_diff_plan
FROM kfl_production_dbp_data.inventur_plan;