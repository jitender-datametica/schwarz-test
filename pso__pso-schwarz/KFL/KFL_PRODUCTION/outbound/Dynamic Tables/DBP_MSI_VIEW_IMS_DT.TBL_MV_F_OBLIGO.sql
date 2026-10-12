CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_obligo
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.psp_id AS psp_id,
  v03.ims_projekt_typ_id AS projekt_typ_id,
  v01.gj AS gj,
  v01.buchungsperiode_id AS buchungsperiode_id,
  COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
  v01.dat_buch AS dat_buch,
  v01.dat_beleg AS dat_beleg,
  v01.ref_beleg_id AS ref_beleg_id,
  v01.ref_beleg_pos_id AS ref_beleg_pos_id,
  v01.krk_id AS krk_id,
  COALESCE(v01.in_lief_id, -1) AS in_lief_id,
  v01.auftrag_id AS auftrag_id,
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
  CASE WHEN v01.sparte_id IN (4, 6, 8) THEN 5 ELSE v01.sparte_id END AS sparte_id,
  COALESCE(v01.in_art_id, -1) AS in_art_id,
  v01.obligo_version_id AS obligo_version_id,
  v01.obligo_wrg_typ_id AS obligo_wrg_typ_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  COALESCE(v01.kostenstelle_id, '') AS kostenstelle_id,
  v01.bestell_text AS bestell_text,
  v01.betrag_plan AS betrag_plan,
  v01.bedarf_nr AS bedarf_nr,
  v01.wrg_id AS wrg_id,
  v01.betrag AS betrag
FROM kfl_production_dbp_view.v_obligo_per AS v01
INNER JOIN kfl_production_dbp_view.v_in_psp_element AS v02
  ON v01.psp_id = v02.psp_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_in_projekt AS v03
  ON v02.in_projekt_id = v03.in_projekt_id AND v02.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant AS v100
  ON v01.mandant_id = v100.mandant_id
WHERE
  (
    v01.krk_id <> 'DE02' OR v01.mandant_id <> 1
  )
  AND v01.psp_id <> -1
  AND NOT TRIM(COLLATE(v01.kostenart_id, ''), '0') IN ('912000', '979002', 'H912000', 'H979002');
