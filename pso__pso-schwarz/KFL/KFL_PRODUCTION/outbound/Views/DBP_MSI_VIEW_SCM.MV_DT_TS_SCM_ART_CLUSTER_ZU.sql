CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_ts_scm_art_cluster_zu (
MANDANT_ID BIGNUMERIC(38,0),
ART_ID BIGNUMERIC(38,0),
ART_CLUSTER_ID BIGNUMERIC(38,0),
ART_CLUSTER_ZU_FG INTEGER
) AS
SELECT V01.mandant_id,
 V01.art_id,
 COALESCE(V03.art_cluster_id, - 99) AS art_cluster_id,
  CASE
  WHEN V03.art_cluster_id IS NULL
  THEN 0
  ELSE 1
  END AS art_cluster_zu_fg
FROM kfl_production_dbp_view.v_art AS V01
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_art_cluster_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id =
   V02.art_id
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_l_art_cluster AS V03 ON V02.mandant_id = V03.mandant_id AND V02.art_cluster_id
     = V03.art_cluster_id AND COALESCE(V03.art_cluster_del_fg, 0) = 0
WHERE EXISTS (SELECT 1
  FROM kfl_production_dbp_view.v_art_wup_autodispo_flw_tag AS AD
  WHERE mandant_id = V01.mandant_id
   AND art_id = V01.art_id
   AND menge_einh_id = 'BME'
   AND EXTRACT(YEAR FROM dat) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2);