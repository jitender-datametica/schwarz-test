CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_wewa_row
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  brk.mandant_id AS mandant_id,
  brk.rech_beleg_id AS rech_beleg_id,
  brk.rech_beleg_kont_pos_id AS rech_beleg_kont_pos_id,
  COALESCE(br.wup_id, 0) AS wup_id,
  COALESCE(br.nb_id, -1) AS nb_id,
  br.gp_id AS gp_id,
  br.dat_buch AS dat_buch,
  CAST(-2 AS BIGNUMERIC) AS art_id,
  br.gj AS wewa_jahr,
  v300.umrechnungskurs AS umrechnungskurs_0,
  v400.umrechnungskurs AS umrechnungskurs_1,
  br.mandant_id AS mandant_id_br,
  br.kursf AS kursf_br,
  brk.betrag_beleg AS betrag_beleg_brk,
  SUBSTR(CASE WHEN NOT v04.posten_id IN ('1') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_besch_rech_det_kont AS brk
INNER JOIN kfl_production_dbp_view.v_besch_rech AS br
  ON brk.mandant_id = br.mandant_id
  AND brk.rech_beleg_id = br.rech_beleg_id
  AND brk.gj = br.gj
INNER JOIN kfl_production_dbp_view.v_mandant AS m
  ON brk.mandant_id = m.mandant_id
INNER JOIN kfl_production_dbp_view.v_kurs AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND m.default_wrg = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR'
INNER JOIN kfl_production_dbp_view.v_kurs AS v400
  ON br.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
  AND m.default_wrg = v400.von_wrg_id
  AND v400.kurstyp_id = 3
  AND v400.nach_wrg_id = 'EUR'
LEFT JOIN kfl_production_dbp_view.v_art_per AS v04
  ON -2 = v04.art_id
  AND brk.mandant_id = v04.mandant_id
  AND br.dat_buch BETWEEN DATE_SUB(v04.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v04.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  brk.mandant_id IN (2, 3, 5, 6)
  AND brk.sachkonto_id IN ('R097761', 'R097762', 'R097763')
  OR brk.mandant_id IN (7, 8)
  AND brk.sachkonto_id IN ('0000097761', '0000097762', '0000097763');
