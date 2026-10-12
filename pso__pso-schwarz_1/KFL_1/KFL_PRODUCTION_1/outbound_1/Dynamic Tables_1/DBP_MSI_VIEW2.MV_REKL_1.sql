CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_rekl_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  r.dat AS dat,
  r.art_id AS art_id,
  r.mandant_id AS mandant_id,
  r.wup_id AS wup_id,
  r.nb_id AS nb_id,
  r.reklamationsgrund_id AS reklamationsgrund_id,
  r.vk_brutto_re AS rekl_vk_brutto,
  r.vk_menge_re AS rekl_vk_menge,
  r.gp_id AS gp_id,
  r.mhd AS mhd,
  r.los_charge AS los_charge,
  a.mwst_id AS mwst_id,
  m.mwst AS mwst,
  r.art_id_ref AS art_id_ref,
  r.kunden_text AS kunden_text
FROM kfl_production_dbp_view.v_rekl_1 AS r
INNER JOIN kfl_production_dbp_view.v_art_1 AS a
  ON r.art_id = a.art_id AND r.mandant_id = a.mandant_id
INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS m
  ON a.mwst_id = m.mwst_id AND a.mandant_id = m.mandant_id
WHERE
  r.mandant_id = 1 AND r.dat BETWEEN m.dat_von AND m.dat_bis AND r.bon_storno_fg = 0;
