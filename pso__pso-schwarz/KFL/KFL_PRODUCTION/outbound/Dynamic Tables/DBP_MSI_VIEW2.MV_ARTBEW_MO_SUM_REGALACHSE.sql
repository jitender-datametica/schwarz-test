CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_mo_sum_regalachse
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  a.kjmo AS kjmo,
  a.art_id AS art_id,
  r.fbb_nr AS fbb_nr,
  r.fachboden_nr AS fachboden_nr,
  r.fachboden_pos AS fachboden_pos,
  a.bewart_id AS bewart_id,
  a.mandant_id AS mandant_id,
  a.wup_id AS wup_id,
  a.nb_id AS nb_id,
  a.gp_id AS gp_id,
  a.herst_id AS herst_id,
  CAST(a.diff_umsatz_netto_konz AS BIGNUMERIC) * r.kapazitaet_faktor AS diff_netto_ums_konz,
  CAST(a.ek_mep AS BIGNUMERIC) * r.kapazitaet_faktor AS ek_mep_umsatz,
  CAST(a.umsatz_mwst_betrag AS BIGNUMERIC) * r.kapazitaet_faktor AS umsatz_mwst_betrag,
  CAST(a.umsatz_netto AS BIGNUMERIC) * r.kapazitaet_faktor AS umsatz_netto,
  CAST(a.menge AS BIGNUMERIC) * r.kapazitaet_faktor AS vk_menge,
  CAST(a.logkostenzuschlag AS BIGNUMERIC) * r.kapazitaet_faktor AS logkostenzuschlag
FROM kfl_production_dbp_view.v_artbew_mo_sum AS a
INNER JOIN kfl_production_dbp_view.v_regalachse_akt AS r
  ON a.art_id = r.art_id
  AND a.mandant_id = r.mandant_id
  AND a.wup_id = r.wup_id
  AND a.nb_id = r.nb_id
WHERE
  a.mandant_id = 1 AND r.mandant_id = 1 AND r.aktiv_fg = 1;
