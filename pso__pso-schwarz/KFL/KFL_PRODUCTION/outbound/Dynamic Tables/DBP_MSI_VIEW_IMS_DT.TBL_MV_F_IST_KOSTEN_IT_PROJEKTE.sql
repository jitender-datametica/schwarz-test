CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_ist_kosten_it_projekte
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  CASE
    WHEN v01.sparte_id IN (6, 8)
    THEN 1
    WHEN v01.mandant_id = 1
    THEN 2
    WHEN v01.mandant_id = 2
    THEN 3
    WHEN v01.mandant_id = 3
    THEN 6
    WHEN v01.mandant_id = 5
    THEN 4
    WHEN v01.mandant_id = 6
    THEN 5
    WHEN v01.mandant_id = 7
    THEN 7
    WHEN v01.mandant_id = 8
    THEN 8
    ELSE NULL
  END AS it_plan_ebene_id,
  v01.psp_id AS it_psp_id,
  v02.psp_id_char AS it_psp_id_char,
  v01.gj AS gj,
  v01.buchungsperiode_id AS buchungsperiode_id,
  COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
  v01.dat_buch AS dat_buch,
  v01.dat_beleg AS dat_beleg,
  v01.beleg_id AS beleg_id,
  v01.beleg_pos_id AS beleg_pos_id,
  COALESCE(v01.in_art_id, -1) AS in_art_id,
  v01.krk_id AS krk_id,
  COALESCE(v01.geschaeftsbereich_id, '-1') AS geschaeftsbereich_id,
  COALESCE(v01.in_lief_id, -1) AS in_lief_id,
  COALESCE(v01.ref_beleg_id, 0) AS ref_beleg_id,
  LTRIM(COLLATE(v01.kostenart_id, ''), '0') AS kostenart_id,
  COALESCE(v01.anlage_id, '') AS anlage_id,
  COALESCE(v01.anlage_sub_id, 0) AS anlage_sub_id,
  CAST(CASE
    WHEN v01.anlage_id IS NULL
    THEN CAST(-1 AS BIGNUMERIC)
    ELSE v01.buchungskreis_id
  END AS BIGNUMERIC) AS anlage_buchungskreis_id,
  v01.berichts_position_it_id AS berichts_position_it_id,
  v01.berichts_position_invest_id AS berichts_position_invest_id,
  CASE
    WHEN LTRIM(COLLATE(v01.kostenart_id, ''), '0') = '506005'
    THEN 4
    WHEN LTRIM(COLLATE(v01.kostenart_id, ''), '0') = '580405'
    THEN 5
    WHEN LTRIM(COLLATE(v01.kostenart_id, ''), '0') = '880100'
    THEN 7
    ELSE v01.berichts_position_it_id
  END AS berichts_position_it_rwi_id,
  CASE WHEN v01.sparte_id = 8 THEN 5 ELSE v01.sparte_id END AS sparte_id,
  COALESCE(v01.kostenstelle_id, '') AS kostenstelle_id,
  COALESCE(LTRIM(COLLATE(v04.gegenkonto_id_, ''), '0'), '') AS gegenkonto_id,
  COALESCE(v01.beleg_bez, '') AS beleg_bez,
  COALESCE(v01.best_beleg_id, 0) AS best_beleg_id,
  COALESCE(v01.best_beleg_pos_id, 0) AS best_beleg_pos_id,
  v01.bestell_text AS bestell_text,
  v01.ref_buchungskreis_id AS ref_buchungskreis_id,
  v01.belegart_id AS belegart_id,
  v01.hb2_fg AS hb2_fg,
  v01.bedarf_nr AS bedarf_nr,
  v01.betrag AS betrag,
  v01.wrg_id AS wrg_id
FROM kfl_production_dbp_view.v_ist_kosten_det AS v01
INNER JOIN kfl_production_dbp_view.v_in_psp_element AS v02
  ON v01.psp_id = v02.psp_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_in_projekt AS v03
  ON v02.in_projekt_id = v03.in_projekt_id AND v02.mandant_id = v03.mandant_id
LEFT JOIN (
  SELECT
    kostenart_id AS gegenkonto_id_
  FROM kfl_production_dbp_view.v_kostenart AS v04
  WHERE
    mandant_id = 1 AND krk_id = 'XX01'
) AS v04
  ON v01.gegenkonto_id = v04.gegenkonto_id_
INNER JOIN kfl_production_dbp_view.v_mandant AS v100
  ON v01.mandant_id = v100.mandant_id
WHERE
  (
    v01.krk_id <> 'DE02' OR v01.mandant_id <> 1
  )
  AND v03.ims_projekt_typ_id = 'P'
  AND v02.statistisch_fg = 1
  AND v01.hb2_fg = 1
  AND NOT TRIM(COLLATE(v01.kostenart_id, ''), '0') IN ('912000', '979002', 'H912000', 'H979002', '940003');
