CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_obligo_it_projekte_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.psp_id AS it_psp_id,
  v02.psp_id_char AS it_psp_id_char,
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
  COALESCE(v01.in_art_id, -1) AS in_art_id,
  v01.gj AS gj,
  v01.buchungsperiode_id AS buchungsperiode_id,
  COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
  v01.dat_buch AS dat_buch,
  v01.dat_beleg AS dat_beleg,
  v01.ref_beleg_id AS ref_beleg_id,
  v01.ref_beleg_pos_id AS ref_beleg_pos_id,
  v01.krk_id AS krk_id,
  COALESCE(v01.in_lief_id, -1) AS in_lief_id,
  LTRIM(COLLATE(v01.kostenart_id, ''), '0') AS kostenart_id,
  COALESCE(v01.anlage_id, '') AS anlage_id,
  COALESCE(v01.anlage_sub_id, 0) AS anlage_sub_id,
  CAST(CASE
    WHEN v01.anlage_id IS NULL
    THEN CAST(-1 AS BIGNUMERIC)
    ELSE v01.buchungskreis_id
  END AS BIGNUMERIC) AS anlage_buchungskreis_id,
  v01.berichts_position_it_id AS berichts_position_it_id,
  v01.berichts_position_it_id AS berichts_position_it_rwi_id,
  CASE WHEN v01.sparte_id = 8 THEN 5 ELSE v01.sparte_id END AS sparte_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  COALESCE(v01.kostenstelle_id, '') AS kostenstelle_id,
  v01.bestell_text AS bestell_text,
  v01.betrag_plan AS betrag_plan,
  v01.bedarf_nr AS bedarf_nr,
  v01.wrg_id AS wrg_id,
  v01.betrag AS betrag,
  v01.obligo_version_id AS obligo_version_id,
  v01.obligo_wrg_typ_id AS obligo_wrg_typ_id,
  v01.ref_belegart_id AS ref_belegart_id,
  v01.ref_termin_pos_id AS ref_termin_pos_id,
  v01.ref_kontierung_id AS ref_kontierung_id,
  v01.ref_objektart_id AS ref_objektart_id
FROM kfl_production_dbp_view.v_obligo_per_2 AS v01
INNER JOIN kfl_production_dbp_view.v_in_psp_element_2 AS v02
  ON v01.psp_id = v02.psp_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_in_projekt_2 AS v03
  ON v02.in_projekt_id = v03.in_projekt_id AND v02.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_2 AS v100
  ON v01.mandant_id = v100.mandant_id
WHERE
  (
    v01.krk_id <> 'DE02' OR v01.mandant_id <> 1
  )
  AND v03.ims_projekt_typ_id = 'P'
  AND v02.statistisch_fg = 1
  AND NOT COLLATE(v01.kostenart_id, '') LIKE '912000'
  AND NOT COLLATE(v01.kostenart_id, '') LIKE '979002'
  AND NOT COLLATE(v01.kostenart_id, '') LIKE 'H912000'
  AND NOT COLLATE(v01.kostenart_id, '') LIKE 'H979002'
QUALIFY
  (
    RANK() OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), v01.krk_id, v01.obligo_version_id, v01.obligo_wrg_typ_id, v01.ref_beleg_id, CAST(v01.ref_beleg_pos_id AS STRING), v01.ref_belegart_id, CAST(v01.ref_termin_pos_id AS STRING), CAST(v01.ref_kontierung_id AS STRING), v01.ref_objektart_id, v01.dat_bis
      ORDER BY v01.dat_von IS NULL, v01.dat_von
    )
  ) = 1;
