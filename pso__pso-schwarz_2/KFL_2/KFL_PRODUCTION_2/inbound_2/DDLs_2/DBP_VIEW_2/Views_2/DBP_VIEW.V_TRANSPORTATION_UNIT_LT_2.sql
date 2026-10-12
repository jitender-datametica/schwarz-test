CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTATION_UNIT_LT_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,transportation_unit_id                   COMMENT 'Transporteinheit (intern)'
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,transportation_unit_sr_act_id            COMMENT 'Warenannahme- und Versandaktivitätsnummer: Transporteinheit'
  ,beleg_id                                 COMMENT 'Beleg-ID'
  ,at_guid                                  COMMENT 'Produkt'
  ,menge_defekt_tortausch                   COMMENT 'Number of defective load carriers from direct exchange'
  ,menge_gesamt                             COMMENT 'Gesamtmenge'
  ,menge_gesamt_tortausch                   COMMENT 'Total number of Loading Carriers from Direct Exchange'
  ,menge_einh_id                            COMMENT 'Mengeneinheit'
  ,datzeit_erstelliung                      COMMENT 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) '
)
COMMENT = 'Ermittelte Greenfield Tore'
 AS 
    SELECT 
        mandant_id,
        transportation_unit_id,
        kj_transportation_unit,
        transportation_unit_sr_act_id,
        beleg_id,
        at_guid,
        menge_defekt_tortausch,
        menge_gesamt,
        menge_gesamt_tortausch,
        menge_einh_id,
        datzeit_erstelliung

FROM DBP_DATA.TRANSPORTATION_UNIT_LT_2 ;