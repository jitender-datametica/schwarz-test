--==============================================================
-- Table: promotion_event_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: promotion_event_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 17:13:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.promotion_event_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
promotion_event_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Promotion Events.'),
dat_promotion_event_gueltig_von DATE NOT NULL OPTIONS(description='Datum, ab dem das Promotion Event gültig ist.'),
dat_promotion_event_gueltig_bis DATE NOT NULL OPTIONS(description='Datum, bis das Promotion Event gültig ist.'),
werbemittel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbemittels'),
werbemittelkanal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbemittelkanals'),
werbethema_id BIGNUMERIC(38,0) OPTIONS(description='ID des Werbethemas'),
werbeflaechenthema_cd STRING(50) OPTIONS(description='Code des Werbeflaechenthemas'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, promotion_event_id) NOT ENFORCED
)
OPTIONS(description='Tabelle enthält Stammdaten zum promotion event. Ein Promotion Event kann mehrere Angebote zu einer Werbung über einem Werbemittel zusammenfassen.');