CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ladungstraeger_wa_2 (mandant_id, lagernummer_id,
lagersortiment_id, artikelsortiment_id, dat_lief_soll, lief_pal_typ_id, lief_pal_typ_dwh_id, werbeware_id,
wg_verkett_lief, lief_typ_id, lief_beleg_id, kunde_id, transportation_unit_id, kj_transportation_unit, hu_status_id,
handling_unit_id, handling_unit_id_ext, hu_typ_id, art_id, anz_pack_hilfsmittel) AS SELECT T0.mandant_id,
 T0.lagernummer_id,
 T0.lagersortiment_id,
  CASE
  WHEN LEFT(RIGHT(T0.versandstelle_id, 2), 1) = '5'
  THEN '1'
  WHEN LEFT(RIGHT(T0.versandstelle_id, 2), 1) = '7'
  THEN '2'
  ELSE LEFT(RIGHT(T0.versandstelle_id, 2), 1)
  END AS artikelsortiment_id,
 T0.dat_lief_soll,
 T0.lief_pal_typ_id,
 T0.lief_pal_typ_dwh_id,
 T0.werbeware_id,
 T0.wg_verkett_lief,
 T0.lief_typ_id,
 T0.lief_beleg_id,
 T3.aktuell_wup_id AS kunde_id,
 T0.transportation_unit_id,
 EXTRACT(YEAR FROM T0.dat_tour) AS kj_transportation_unit,
 T2.hu_status_id,
 T0.handling_unit_id,
 T0.handling_unit_id_ext,
 T1.hu_typ_id,
 T1.art_id,
 T1.anz_pack_hilfsmittel
FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_2 AS T0
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS T3 ON T3.mandant_id = CASE
     WHEN T0.mandant_id_kunde IS NULL OR T0.mandant_id_kunde = 0
     THEN T0.mandant_id
     ELSE T0.mandant_id_kunde
     END AND T0.kunde_id = T3.wup_id AND (T3.nb_id IN (2, 0, - 111) AND T3.wup_id > 0 OR T3.nb_id = - 1 AND T3.wup_id =
      0)
 INNER JOIN kfl_production_dbp_view.v_handling_unit_det_2 AS T1_2 ON T0.mandant_id = T1.mandant_id AND T0.wup_id = T1.wup_id
       AND T0.nb_id = T1.nb_id AND T0.handling_unit_id = T1.handling_unit_id AND T1.hu_typ_id = 2
 INNER JOIN kfl_production_dbp_view.v_handling_unit_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id AND
    T1.nb_id = T2.nb_id AND T1.handling_unit_id = T2.handling_unit_id
WHERE EXTRACT(YEAR FROM T0.dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2;