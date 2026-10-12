CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_nachlaufpaletten_1 (mandant_id, wup_id, dat_tour,
transportation_unit_id, kj_transportation_unit, dat_lief_soll, lief_pal_typ_id, lief_beleg_id, mandant_id_kunde,
kunde_id, handling_unit_id, handling_unit_id_ext, lief_typ_id, lagersortiment_id, artikelsortiment_id, hu_aufgepackt,
werbeware_id, lagernummer_id, tms, belos_sonderabwicklung_id, tour_service_id, belos_tourart_id, tourart_id,
anzahl_stellplatz_ewm, anzahl_stellplatz_ewm_ext_parent, abweichung_in_tagen, abweichung_in_tagen_bereinigt,
menge_lief_ist_kolli_hu, brtvol_hu_gedeckelt_oa, brtgew_hu_oa, vol_relevant_fg, distribution_abr_fg, versandstelle_id,
transportsortiment_id) AS SELECT HU_S.mandant_id,
 HU_S.wup_id,
 T_UNIT.dat_tour,
 HU_S.transportation_unit_id,
 T_UNIT.kj_transportation_unit,
 HU_S.dat_lief_soll,
 HU_S.lief_pal_typ_id,
 HU_S.lief_beleg_id,
 HU_S.mandant_id_kunde,
 W.aktuell_wup_id AS kunde_id,
 HU_S.handling_unit_id,
 HU_S.handling_unit_id_ext,
 HU_S.lief_typ_id,
 HU_S.lagersortiment_id,
  CASE
  WHEN LEFT(RIGHT(HU_S.versandstelle_id, 2), 1) = '5'
  THEN '1'
  WHEN LEFT(RIGHT(HU_S.versandstelle_id, 2), 1) = '7'
  THEN '2'
  ELSE LEFT(RIGHT(HU_S.versandstelle_id, 2), 1)
  END AS artikelsortiment_id,
  CASE
  WHEN HU_S.handling_unit_id_parent <> 0
  THEN 1
  ELSE 0
  END AS hu_aufgepackt,
 HU_S.werbeware_id,
 HU_S.lagernummer_id,
  CASE
  WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
  THEN 'WANKO'
  ELSE 'BELOS'
  END AS tms,
 T_UNIT.belos_sonderabwicklung_id,
  CASE
  WHEN CASE
    WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN tms0.tour_service
  WHEN T_UNIT.belos_sonderabwicklung_id = 'TK'
  THEN 'TIKO'
  WHEN T_UNIT.belos_sonderabwicklung_id = 'GK'
  THEN 'GK'
  WHEN T_UNIT.belos_sonderabwicklung_id = 'TE'
  THEN 'TG'
  WHEN T_UNIT.belos_sonderabwicklung_id = 'UK'
  THEN 'UGK'
  ELSE '-1'
  END AS tour_service_id,
 T_UNIT.belos_tourart_id,
  CASE
  WHEN CASE
    WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(tms0.tms_tourart_detail_id, -1)
  ELSE COALESCE(T_UNIT.belos_tourart_id, -1)
  END AS tourart_id,
 HU_S.anzahl_stellplatz_ewm,
 HU_S.anzahl_stellplatz_ewm_ext_parent,
 DATE_DIFF(T_UNIT.dat_tour, HU_S.dat_lief_soll, DAY) AS abweichung_in_tagen,
 SUM(CASE
   WHEN T_UNIT.dat_tour < bl_bereinigt.dat_lief_soll
   THEN - 1
   WHEN T_UNIT.dat_tour > bl_bereinigt.dat_lief_soll
   THEN 1
   WHEN T_UNIT.dat_tour = bl_bereinigt.dat_lief_soll
   THEN 0
   ELSE NULL
   END) AS abweichung_in_tagen_bereinigt,
 MAX(HU_S.menge_lief_ist_kolli_hu) AS menge_lief_ist_kolli_hu,
 MAX(HU_S.brtvol_hu_gedeckelt_oa) AS brtvol_hu_gedeckelt_oa,
 MAX(HU_S.brtgew_hu_oa) AS brtgew_hu_oa,
 HU_S.vol_relevant_fg,
  CASE
  WHEN CASE
    WHEN T_UNIT.dat_tour >= b_w_sw.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN CAST(COALESCE(tms0.distribution_abr_fg, 1) AS BIGNUMERIC)
  ELSE COALESCE(bv.distribution_abr_fg, 1)
  END AS distribution_abr_fg_,
 HU_S.versandstelle_id,
 HU_S.transportsortiment_id
FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_1 AS HU_S
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS W ON W.mandant_id = CASE
     WHEN HU_S.mandant_id_kunde IS NULL OR HU_S.mandant_id_kunde = 0
     THEN HU_S.mandant_id
     ELSE HU_S.mandant_id_kunde
     END AND HU_S.kunde_id = W.wup_id AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet_1 AS T_UNIT_1 ON T_UNIT.aktivitaet_richtung_id = '2'
     AND HU_S.handling_unit_id > 0 AND HU_S.mandant_id = T_UNIT.mandant_id AND HU_S.transportation_unit_id = T_UNIT.transportation_unit_id
     AND HU_S.dat_tour = T_UNIT.dat_tour
 INNER JOIN (SELECT mandant_id_kunde,
   kunde_id,
   dat_lief_soll
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_1
  WHERE lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC', 'YCD2', 'ZDD')
   AND handling_unit_id > 0
  GROUP BY mandant_id_kunde,
   kunde_id,
   dat_lief_soll) AS bl_bereinigt ON HU_S.mandant_id_kunde = bl_bereinigt.mandant_id_kunde AND HU_S.kunde_id = SAFE_CAST(bl_bereinigt
     .kunde_id AS BIGNUMERIC) AND (bl_bereinigt.dat_lief_soll BETWEEN T_UNIT.dat_tour AND HU_S.dat_lief_soll OR
     bl_bereinigt.dat_lief_soll BETWEEN HU_S.dat_lief_soll AND T_UNIT.dat_tour)
 LEFT JOIN (SELECT mandant_id,
   lagernummer_id,
   MIN(dat_tms_wanko) AS dat_tms_wanko
  FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_1
  WHERE dat_tms_wanko IS NOT NULL
  GROUP BY mandant_id,
   lagernummer_id) AS b_w_sw ON T_UNIT.mandant_id = b_w_sw.mandant_id AND T_UNIT.lagernummer_id = b_w_sw.lagernummer_id
 LEFT JOIN (SELECT T.mandant_id,
   TU.transportation_unit_id,
   T.dat_tour,
    CASE
    WHEN T.tms_tourtyp_id = 105
    THEN 0
    ELSE 1
    END AS distribution_abr_fg,
    CASE
    WHEN T.sortiment_temperaturgruppe_id = 1
    THEN 'TK'
    WHEN T.sortiment_temperaturgruppe_id = 2
    THEN 'GK'
    WHEN T.sortiment_temperaturgruppe_id = 3
    THEN 'TE'
    ELSE 'UK'
    END AS tour_service,
   T.tms_tourart_detail_id
  FROM kfl_production_dbp_data.tms_tour_1 AS T
   INNER JOIN kfl_production_dbp_view.v_transportation_unit_1 AS TU ON T.mandant_id = TU.mandant_id AND T.transportation_unit_id_ext
      = TU.transportation_unit_id_ext
  WHERE EXTRACT(YEAR FROM T.dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
  GROUP BY T.mandant_id,
   TU.transportation_unit_id,
   T.dat_tour,
   tour_service,
   T.tms_tourart_detail_id,
   distribution_abr_fg) AS tms0 ON T_UNIT.mandant_id = tms0.mandant_id AND T_UNIT.transportation_unit_id = tms0.transportation_unit_id
     AND T_UNIT.dat_tour = tms0.dat_tour
 LEFT JOIN (SELECT mandant_id,
   tour_id,
   dat_leistung,
   MAX(distribution_abr_fg) AS distribution_abr_fg
  FROM kfl_production_dbp_view.v_belos_vorgang_1
  GROUP BY mandant_id,
   tour_id,
   dat_leistung) AS bv ON T_UNIT.mandant_id = bv.mandant_id AND T_UNIT.transportation_unit_id = bv.tour_id AND T_UNIT.dat_tour
    = bv.dat_leistung
WHERE T_UNIT.kj_transportation_unit >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
GROUP BY HU_S.mandant_id,
 HU_S.wup_id,
 T_UNIT.dat_tour,
 HU_S.transportation_unit_id,
 T_UNIT.kj_transportation_unit,
 HU_S.dat_lief_soll,
 HU_S.lief_pal_typ_id,
 HU_S.lief_beleg_id,
 HU_S.mandant_id_kunde,
 kunde_id,
 HU_S.handling_unit_id,
 HU_S.handling_unit_id_ext,
 HU_S.lief_typ_id,
 HU_S.werbeware_id,
 HU_S.lagernummer_id,
 HU_S.versandstelle_id,
 HU_S.lagersortiment_id,
 T_UNIT.belos_sonderabwicklung_id,
 T_UNIT.belos_tourart_id,
 HU_S.anzahl_stellplatz_ewm,
 HU_S.anzahl_stellplatz_ewm_ext_parent,
 HU_S.vol_relevant_fg,
 abweichung_in_tagen,
 hu_aufgepackt,
 distribution_abr_fg_,
 tms,
 HU_S.transportsortiment_id,
 tour_service_id,
 tourart_id;