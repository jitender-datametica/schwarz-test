CREATE TABLE DBP_DATA.BEWART_DET_ECOMMERCE_2 (
   kundenkarte_id                      VARCHAR(255)    NOT NULL COMMENT 'Nummer der Kundenkarte/ Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH - entspricht i.d.R. einem Land_2'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Loyalty - artbew.bewart_det_id - Steuerungstabelle für Sonderbehandlung E-Commerce-Karten - Tabellenpflege durch Transaction-Service-Bericht';
