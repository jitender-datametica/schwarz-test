CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kommunikationskanal_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), kommunikationskanal_id
OPTIONS(description='Eindeutige Kennung des Kommunikationskanals, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DIE VERFÜGBAREN KOMMUNIKATIONSKANÄLE FÜR MARKETINGKAMPAGNEN.`) AS SELECT
 mandant_id,
 kommunikationskanal_id
FROM kfl_production_dbp_data.l_kommunikationskanal_2;