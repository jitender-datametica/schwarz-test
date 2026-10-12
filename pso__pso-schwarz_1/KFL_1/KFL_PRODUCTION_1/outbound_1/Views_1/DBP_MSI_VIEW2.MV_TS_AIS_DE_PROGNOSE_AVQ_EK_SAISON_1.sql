CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ts_ais_de_prognose_avq_ek_saison_1 AS WITH T_RANK AS (SELECT
  DISTINCT mandant_id,
   ek_saison_id,
   dat_gueltig_von,
   dat_gueltig_bis,
   DENSE_RANK() OVER (PARTITION BY CAST(ek_saison_id AS STRING) ORDER BY dat_gueltig_von IS NULL DESC, dat_gueltig_von
      DESC) AS abfolge
  FROM kfl_production_dbp_msi_view2.ts_ais_de_ek_saison_art_zu_1), T_AKT_ZEITRAUM AS (SELECT mandant_id,
   ek_saison_id,
   dat_gueltig_von,
   dat_gueltig_bis
  FROM T_RANK
  WHERE abfolge = 1) (SELECT v01.mandant_id,
   v01.ek_saison_id,
   v01.dat_gueltig_von AS dat_von,
   v01.dat_gueltig_bis AS dat_bis,
   V02.dat,
   COALESCE(V03.menge_absatz_prognose, 0) AS saison_menge_absatz_prognose,
   COALESCE(FIRST_VALUE(CASE
      WHEN V02.akt_tag <= 0
      THEN V03.menge_absatz_prognose
      ELSE 0
      END) OVER (PARTITION BY CAST(v01.ek_saison_id AS STRING) ORDER BY CASE
        WHEN V02.akt_tag <= 0
        THEN 1
        ELSE 10
        END IS NULL, CASE
        WHEN V02.akt_tag <= 0
        THEN 1
        ELSE 10
        END, V02.akt_tag IS NULL DESC, V02.akt_tag DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0)
   AS saison_menge_absatz_prognose_akt_tag_0
  FROM T_AKT_ZEITRAUM AS v01
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V02.dat BETWEEN v01.dat_gueltig_von AND v01.dat_gueltig_bis
   LEFT JOIN kfl_production_dbp_msi_view2.ts_ais_de_prognose_avq_ek_saison_tag_1 AS V03 ON v01.mandant_id = V03.mandant_id
       AND v01.ek_saison_id = V03.ek_saison_id AND V02.dat = V03.dat_prognose);