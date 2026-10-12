CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BEWART_DET_ECOMMERCE_2 (
KUNDENKARTE_ID STRING(255) NOT NULL
OPTIONS(description='Nummer der Kundenkarte/ Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - entspricht i.d.R. einem Land_2'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='Loyalty - artbew.bewart_det_id - Steuerungstabelle für Sonderbehandlung E-Commerce-Karten - Tabellenpflege durch Transaction-Service-Bericht');