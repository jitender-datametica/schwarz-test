CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_besch_lief_wa_det_1 (USERID STRING) AS SELECT V01.mandant_id,
 V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.handling_unit_id,
 V01.handling_unit_pos_id,
 V01.hu_typ_id,
 V01.best_beleg_id,
 V01.transportation_unit_id,
 EXTRACT(YEAR FROM V01.dat_tour) AS kj_transportation_unit,
 V01.wup_id,
 V01.nb_id,
 V01.lagernummer_id,
 V01.versandstelle_id,
 V01.lagerort_id,
 V01.lagersortiment_id,
  CASE
  WHEN LEFT(RIGHT(V01.versandstelle_id, 2), 1) = '5'
  THEN '1'
  WHEN LEFT(RIGHT(V01.versandstelle_id, 2), 1) = '7'
  THEN '2'
  ELSE LEFT(RIGHT(V01.versandstelle_id, 2), 1)
  END AS artikelsortiment_id,
 COALESCE(V01.transportsortiment_id, '-1') AS transportsortiment_id,
 V01.diff_id,
 V01.dat_lief_soll,
 V01.lief_typ_id,
 V01.vertr_beleg_typ_id,
 V01.art_id,
 COALESCE(V06.aktuell_wup_id, V01.kunde_id) AS kunde_id,
 V01.wg_verkett_lief,
 V01.menge_lief_soll_kolli,
 V01.menge_lief_ist_kolli,
 v05a.menge_lief_ist_kolli_incl_charsplit_agg AS menge_lief_ist_kolli_incl_charsplit,
 V01.menge_lief_soll_bme,
 V01.menge_lief_ist_bme,
 V01.lief_pal_typ_id,
 V01.lief_pal_typ_dwh_id,
 V01.mandant_id_kunde,
 V01.werbeware_id,
 V01.bestellart_id,
 V01.hu_status_id,
 V01.handling_unit_id_ext_parent,
 V01.handling_unit_id_ext,
 V01.handling_unit_id_parent,
 V01.originalposition_lief_fg,
 V01.position_charg_split_fg,
 V01.uebg_chargensplit_pos,
 V01.disponent_id,
 V01.dat_haltbarkeit,
 V01.charge_id,
 COALESCE(V01.auslieferungsgruppe_id, '-1') AS auslieferungsgruppe_id,
 V01.anzahl_packstueck,
  CASE
  WHEN V04.wrg_typ_id = 0
  THEN V01.vk_netto_lief_ist * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_ist
  END AS vk_netto_lief_ist,
  CASE
  WHEN V04.wrg_typ_id = 0
  THEN V01.vk_netto_lief_soll * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll
  END AS vk_netto_lief_soll,
 V01.menge_lief_soll_pal,
 V01.menge_lief_ist_pal,
  CASE
  WHEN V01.wg_verkett_fg = 1
  THEN CAST(WGVER.wg_verkett_hier_id AS STRING)
  ELSE ''
  END AS wg_verkett_hier_id,
 V01.wg_verkett_fg
FROM kfl_production_dbp_view.v_besch_lief_wa_det_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per_1 AS WGVER ON V01.wup_id = WGVER.wup_id AND V01.mandant_id
      = WGVER.mandant_id AND V01.wg_verkett_lief = WGVER.wg_verkett_id AND V01.dat_lief_soll BETWEEN WGVER.dat_von AND
   WGVER.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V06 ON V06.mandant_id = CASE
     WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_kunde
     END AND V01.kunde_id = V06.wup_id AND V06.nb_id = 0
 LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_1 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V04 ON V03.wrg_typ_id = V04.wrg_typ_id
 LEFT JOIN (SELECT dat_lief_soll,
   lief_beleg_id,
   uebg_chargensplit_pos,
   art_id,
   mandant_id,
   SUM(menge_lief_ist_kolli_charsplit) AS menge_lief_ist_kolli_incl_charsplit_agg
  FROM (SELECT dat_lief_soll,
      lief_beleg_id,
      uebg_chargensplit_pos,
      art_id,
      mandant_id,
      SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli_charsplit
     FROM kfl_production_dbp_view.v_besch_lief_wa_det_1 AS V01
     WHERE originalposition_lief_fg = 0
     GROUP BY mandant_id,
      lief_beleg_id,
      dat_lief_soll,
      art_id,
      uebg_chargensplit_pos
     UNION DISTINCT
     SELECT dat_lief_soll,
      lief_beleg_id,
      lief_beleg_pos_id AS uebg_chargensplit_pos,
      art_id,
      mandant_id,
      SUM(menge_lief_ist_kolli) AS menge_lief_ist_kolli_charsplit
     FROM kfl_production_dbp_view.v_besch_lief_wa_det_1 AS V01
     WHERE originalposition_lief_fg = 1
     GROUP BY dat_lief_soll,
      lief_beleg_id,
      uebg_chargensplit_pos,
      art_id,
      mandant_id) AS v05
  GROUP BY dat_lief_soll,
   lief_beleg_id,
   uebg_chargensplit_pos,
   art_id,
   mandant_id) AS v05a ON V01.dat_lief_soll = v05a.dat_lief_soll AND V01.lief_beleg_id = v05a.lief_beleg_id AND V01.lief_beleg_pos_id
      = v05a.uebg_chargensplit_pos AND V01.art_id = v05a.art_id AND V01.mandant_id = v05a.mandant_id;
