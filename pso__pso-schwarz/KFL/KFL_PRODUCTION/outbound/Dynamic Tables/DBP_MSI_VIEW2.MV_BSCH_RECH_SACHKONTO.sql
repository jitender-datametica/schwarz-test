CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_bsch_rech_sachkonto
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v02.mandant_id AS mandant_id,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v01.wg_id AS wg_id,
  v02.dat_leist_erstellung AS dat,
  v03.art_id AS art_id,
  v01.rech_beleg_id AS rech_beleg_id,
  v01.rech_beleg_kont_pos_id AS rech_beleg_kont_pos_id,
  v02.gp_id AS gp_id,
  v01.betrag_beleg AS betrag_beleg,
  CASE WHEN v01.betrag_beleg > 0 THEN v01.betrag_beleg ELSE NULL END AS we_wert_ekn_row,
  CASE WHEN v01.betrag_beleg < 0 THEN v01.betrag_beleg ELSE NULL END AS we_wert_ekn_gow,
  SUBSTR(CASE WHEN NOT v04.posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_besch_rech_det_kont AS v01
LEFT JOIN kfl_production_dbp_view.v_besch_rech AS v02
  ON v01.rech_beleg_id = v02.rech_beleg_id
  AND v01.gj = v02.gj
  AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS v03
  ON v01.wg_id * -1000 = v03.art_id
  AND v01.mandant_id = v03.mandant_id
  AND v01.arthiertyp_id = v03.arthiertyp_id
  AND v03.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_art_per AS v04
  ON v03.art_id = v04.art_id
  AND v02.mandant_id = v04.mandant_id
  AND v02.dat_leist_erstellung BETWEEN DATE_SUB(v04.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v04.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id = 1
  AND RIGHT(v01.sachkonto_id, 6) IN (
    '314602',
    '314603',
    '314604',
    '314605',
    '314606',
    '314607',
    '314608',
    '314609',
    '314610',
    '314611',
    '314612',
    '314616',
    '314617',
    '314621',
    '314622',
    '314623',
    '314624'
  )
  AND v01.row_grund_id IN (
    '100',
    '101',
    '103',
    '104',
    '105',
    '106',
    '107',
    '108',
    '109',
    '110',
    '111',
    '112',
    '114',
    '116',
    '119',
    '120',
    '142',
    '160',
    '161',
    '199'
  );
