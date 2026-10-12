CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ladungstraeger_we_belog_1 AS WITH EKPO_1 AS (SELECT TU_C.mandant_id
   ,
   TU_C.beleg_id AS lief_beleg_id,
   TU_C.transportation_unit_id,
   TU_C.kj_transportation_unit,
   EKPO.best_beleg_id,
   EKES.ext_beleg_id,
   MAX(EKPO.selbstabhol_fg) AS max_selbstabhol_fg
  FROM kfl_production_dbp_view.v_besch_best_det_1 AS EKPO_1
   INNER JOIN kfl_production_dbp_view.v_besch_bestaetigung_1 AS EKES ON EKPO.mandant_id = EKES.mandant_id AND EKPO.best_beleg_id
       = EKES.best_beleg_id AND EKPO.best_beleg_pos_id = EKES.best_beleg_pos_id
   INNER JOIN kfl_production_dbp_view.v_transportation_unit_carrier_log_1 AS TU_C ON EKPO.mandant_id = TU_C.mandant_id AND
      EKES.lief_beleg_id = TU_C.beleg_id AND TU_C.kj_transportation_unit BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 2 AND
      (EXTRACT(YEAR FROM CURRENT_DATE))
  GROUP BY TU_C.mandant_id,
   lief_beleg_id,
   TU_C.transportation_unit_id,
   TU_C.kj_transportation_unit,
   EKPO.best_beleg_id,
   EKES.ext_beleg_id) (SELECT t2.mandant_id,
   t2.transportation_unit_id,
   t2.kj_transportation_unit,
   t2.ext_beleg_id,
   t2.lief_beleg_id,
   t2.max_selbstabhol_fg AS lieferung_has_selbstabhol_fg,
   STRING_AGG(CAST(t2.best_beleg_id AS STRING), ',' ORDER BY t2.mandant_id NULLS LAST, t2.transportation_unit_id
     NULLS LAST) AS best_beleg_ids,
   MAX(tu_sak.tu_has_selbstabhol_fg) AS tu_has_selbstabhol_fg
  FROM EKPO_1 AS t2
   INNER JOIN (SELECT mandant_id,
     transportation_unit_id,
     kj_transportation_unit,
     MAX(max_selbstabhol_fg) AS tu_has_selbstabhol_fg
    FROM EKPO_1
    GROUP BY mandant_id,
     transportation_unit_id,
     kj_transportation_unit) AS tu_sak ON t2.mandant_id = tu_sak.mandant_id AND t2.transportation_unit_id = tu_sak.transportation_unit_id
       AND t2.kj_transportation_unit = tu_sak.kj_transportation_unit
  GROUP BY t2.mandant_id,
   t2.transportation_unit_id,
   t2.kj_transportation_unit,
   t2.ext_beleg_id,
   t2.lief_beleg_id,
   lieferung_has_selbstabhol_fg
  ORDER BY t2.mandant_id NULLS LAST,
   t2.transportation_unit_id NULLS LAST,
   t2.kj_transportation_unit NULLS LAST,
   t2.ext_beleg_id NULLS LAST,
   t2.lief_beleg_id NULLS LAST,
   lieferung_has_selbstabhol_fg NULLS LAST);