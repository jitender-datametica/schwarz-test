CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_kosten_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum ( (hier: nur Speditionen))'),
nb_id OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
transportation_unit_id OPTIONS(description='Transporteinheit (intern)'), kj_transportation_unit
OPTIONS(description='Anlagejahr der Transporteinheit'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_diesel
OPTIONS(description='zusätzliche Kosten für Diesel'), betrag_strom OPTIONS(description='zusätzliche Kosten für Strom'),
betrag_gas OPTIONS(description='zusätzliche Kosten für Gas'), betrag_maut
OPTIONS(description='zusätzliche Kosten für Maut'), betrag_kuehlung
OPTIONS(description='zusätzliche Kosten für Kühlung'), betrag_sonstiges
OPTIONS(description='zusätzliche Kosten weitere'))
OPTIONS(DESCRIPTION = `TABLE FOR ADDITIONAL COSTS PER TRANSPORTATION UNIT_2 THAT ARE NOT INCLUDED IN WANKO BILLING DATA - MAIN SOURCE IS EXCEL FILES, MANUALLY UPLOADED IN SHAREPOINT`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 transportation_unit_id,
 kj_transportation_unit,
 wrg_id,
 betrag_diesel,
 betrag_strom,
 betrag_gas,
 betrag_maut,
 betrag_kuehlung,
 betrag_sonstiges
FROM kfl_production_dbp_data.transportation_unit_kosten_2;