CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTATION_UNIT_LAGERTOR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,transportation_unit_id                   COMMENT 'Transporteinheit (intern)'
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,transportation_unit_sr_act_id            COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit'
  ,ladegruppe_versandstelle_id              COMMENT 'Versandstelle/Warenannahmestelle      '
  ,lagertor_id                              COMMENT 'Lagertor '
  ,datzeit_erstelliung                      COMMENT 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) '
  ,tor_distanz_gewichtung                   COMMENT 'Distanz Gewichtung  '
)
COMMENT = 'Ermittelte Greenfield Tore'
 AS 
    SELECT 
        mandant_id,
        transportation_unit_id,
        kj_transportation_unit,
        transportation_unit_sr_act_id,
        ladegruppe_versandstelle_id,
        lagertor_id,
        datzeit_erstelliung,
        tor_distanz_gewichtung

FROM DBP_DATA.TRANSPORTATION_UNIT_LAGERTOR_ZU_1 ;