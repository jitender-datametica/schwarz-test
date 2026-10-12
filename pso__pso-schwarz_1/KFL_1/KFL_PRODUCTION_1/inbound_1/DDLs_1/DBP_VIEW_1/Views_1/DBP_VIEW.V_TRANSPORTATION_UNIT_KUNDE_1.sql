CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSPORTATION_UNIT_KUNDE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,kunde_id                                 COMMENT 'Markt'
  ,kunde_num_id                             COMMENT 'Markt (numerisch für Join mit wup_1-Tabelle)'
  ,dat_tour                                 COMMENT 'Tour_1 Lieferdatum'
  ,wup_id                                   COMMENT 'Betrieb'
  ,plantour_id                              COMMENT 'Plantournummer'
  ,transportation_unit_id                   COMMENT 'Transportnummer'
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,tour_pos_id                              COMMENT 'Tournummer (entspricht Position)'
  ,zeit_plan_ankunft                        COMMENT 'Anlieferzeit'
)
COMMENT = 'SRS geplante Tourdaten'
 AS 
    SELECT 
        mandant_id,
        kunde_id,
        kunde_num_id,
        dat_tour,
        wup_id,
        plantour_id,
        transportation_unit_id,
        kj_transportation_unit,
        tour_pos_id,
        zeit_plan_ankunft

FROM DBP_DATA.TRANSPORTATION_UNIT_KUNDE_1 ;