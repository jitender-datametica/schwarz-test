CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_ekc_wa_kalk_abschriften_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  a.mandant_id AS mandant_id,
  a.art_id AS art_id,
  b.gp_id AS gp_id,
  a.bewart_id AS bewart_id,
  a.bewart_det_id AS bewart_det_id,
  a.wup_id AS wup_id,
  a.nb_id AS nb_id,
  a.dat AS dat,
  a.wrg_id AS wrg_id,
  a.wup_bereinigt_fg AS wup_bereinigt_fg,
  a.zek_id AS zek_id,
  a.eigenmarke_fg AS eigenmarke_fg,
  CASE
    WHEN a.bewart_id = 1001 AND NOT c.posten_id IN ('PN', 'PF', 'SP')
    THEN ''
    ELSE 'PN'
  END AS posten_id_per,
  CASE WHEN NOT c.posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END AS posten_kz_per,
  a.preis_abschrift_netto AS preis_abschrift_netto
FROM kfl_production_dbp_view.v_artbew_dat_ek_cp_sum_2 AS a
INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS b
  ON a.mandant_id = b.mandant_id
  AND a.art_id = b.art_id
  AND a.wup_id = b.wup_id
  AND a.dat BETWEEN b.dat_von AND b.dat_bis
LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS c
  ON a.art_id = c.art_id
  AND a.mandant_id = c.mandant_id
  AND a.dat BETWEEN DATE_SUB(c.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(c.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  a.mandant_id = 1
  AND a.wup_bereinigt_fg = 0
  AND a.transaktion_typ_id = 1
  AND a.preis_abschrift_netto <> 0;
