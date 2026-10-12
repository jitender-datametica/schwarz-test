CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_art_gp_wup_zu_per_2 (mandant_id, art_id, gp_id, wup_id, nb_id,
dat_von, dat_bis, ek_netto_bnk, logistikkostenzuschlag, bezugsweg_id, komponentenmenge, wrg_id) AS SELECT mandant_id,
 art_id,
 gp_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 ek_netto_bnk,
 logistikkostenzuschlag,
 bezugsweg_id,
 komponentenmenge,
 wrg_id
FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_2
WHERE ek_netto <> 0
QUALIFY (SUM(1) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING), CAST(wup_id AS STRING) ORDER BY
      dat_von IS NULL, dat_von, ek_brutto IS NULL, ek_brutto, gp_id IS NULL, gp_id ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW)) = 1;