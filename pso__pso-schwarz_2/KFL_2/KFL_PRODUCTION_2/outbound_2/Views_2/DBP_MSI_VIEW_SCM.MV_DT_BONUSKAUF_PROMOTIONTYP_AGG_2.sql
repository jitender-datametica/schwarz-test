CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_bonuskauf_promotiontyp_agg_2 (
MANDANT_ID BIGNUMERIC(38,0),
ART_ID BIGNUMERIC(38,0),
WUP_ID BIGNUMERIC(38,0),
NB_ID BIGNUMERIC(38,0),
DAT_VON DATE,
DAT_BIS DATE,
BONUSKAUF_PROMOTIONSTYP_AGG STRING(4)
) AS
SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 STRING_AGG(bonuskauf_promotionstyp, ', ' ORDER BY bonuskauf_promotionstyp IS NULL, bonuskauf_promotionstyp) AS
 bonuskauf_promotionstyp_agg
FROM kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2 AS V05A
WHERE dat_von >= CURRENT_DATE
GROUP BY mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis;