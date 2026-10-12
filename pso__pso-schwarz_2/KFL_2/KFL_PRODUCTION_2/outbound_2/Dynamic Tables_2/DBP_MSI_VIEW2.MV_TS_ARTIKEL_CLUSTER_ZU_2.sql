CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_ts_artikel_cluster_zu_2 AS
WITH t_rank AS (
  SELECT DISTINCT
    ek_saison_id,
    dat_gueltig_von,
    dat_gueltig_bis,
    DENSE_RANK() OVER (
      PARTITION BY CAST(ek_saison_id AS STRING)
      ORDER BY dat_gueltig_von IS NULL DESC, dat_gueltig_von DESC
    ) AS abfolge
  FROM kfl_production_dbp_msi_view2.ts_ais_de_ek_saison_art_zu_2
), t_akt_zeitraum AS (
  SELECT
    ek_saison_id,
    dat_gueltig_von,
    dat_gueltig_bis
  FROM t_rank
  WHERE
    abfolge = 1
)
(
  SELECT
    v01.mandant_id AS mandant_id,
    v01.art_id AS art_id,
    v01.ek_saison_id AS ek_saison_id,
    v01.dat_gueltig_von AS dat_von,
    v01.dat_gueltig_bis AS dat_bis,
    v02.abfolge AS abfolge,
    v03.dat_gueltig_von AS dat_von_akt,
    v03.dat_gueltig_bis AS dat_bis_akt,
    v04.dat AS dat,
    v01.kl_art_id_liste_txt AS kl_art_id_liste_txt
  FROM kfl_production_dbp_msi_view2.ts_ais_de_ek_saison_art_zu_2 AS v01
  INNER JOIN t_rank AS v02
    ON v01.ek_saison_id = v02.ek_saison_id
    AND v01.dat_gueltig_von = v02.dat_gueltig_von
    AND v01.dat_gueltig_bis = v02.dat_gueltig_bis
  INNER JOIN t_akt_zeitraum AS v03
    ON v01.ek_saison_id = v03.ek_saison_id
  INNER JOIN kfl_production_dbp_view.v_tag_2 AS v04
    ON v04.dat BETWEEN v03.dat_gueltig_von AND v03.dat_gueltig_bis
  WHERE
    v01.mandant_id = 1
);
