CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTATION_UNIT_STATUS (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,transportation_unit_id                   COMMENT 'Transporteinheit (intern)'
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,transportation_unit_sr_act_id            COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit'
  ,status_id                                COMMENT 'Statusart'
  ,statuswert                               COMMENT 'Statuswert'
  ,datzeit_buchung                          COMMENT 'Buchungszeitstempel'
  ,statusgrund                              COMMENT 'Grund des Status im WA/V'
)
COMMENT = 'Transporteinheit Status'
 AS 
    SELECT 
        mandant_id,
        transportation_unit_id,
        kj_transportation_unit,
        transportation_unit_sr_act_id,
        status_id,
        statuswert,
        datzeit_buchung,
        statusgrund

FROM DBP_DATA.TRANSPORTATION_UNIT_STATUS ;