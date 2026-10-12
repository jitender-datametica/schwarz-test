CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bewart_det_ecommerce_1 (
kundenkarte_id STRING(255) NOT NULL
OPTIONS(description='Nummer der Kundenkarte/ Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH - entspricht i.d.R. einem Land_1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='Loyalty - artbew.bewart_det_id - Steuerungstabelle für Sonderbehandlung E-Commerce-Karten - Tabellenpflege durch Transaction-Service-Bericht');