
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_rpt_liam_avlbl_cats_nw_1
 AS
SELECT psf.client_id,
 psf.liam_clnt_cat_id,
 psf.liam_chld_cat_desc,
 psf.liam_chld_cat_desc_en,
 psf.liam_clnt_parnt_cat_id,
 psf.liam_parnt_cat_desc,
 psf.liam_parnt_cat_desc_en,
 psf.prom_id,
 COALESCE(fact2.per_id, - 1) AS per_id,
 COALESCE(PER.per_text, 'N/A') AS per_text,
 COALESCE(PER.per_text_en, 'N/A') AS per_text_en,
 COALESCE(fact2.valid_data_flg, 'N') AS valid_data_flg,
 COALESCE(fact2.valid_data_flg_cd, 0) AS valid_data_flg_cd,
  COALESCE(fact2.valid_data_flg_cd, 0) * psf.bnc_prom_total AS exp_delivered_nopromo,
  COALESCE(fact2.valid_data_flg_cd, 0) * psf.bnc_prom_brand_pl AS exp_delivered_promo,
 COALESCE(psf.exp_total_uwg, 0) AS exp_total_uwg,
 COALESCE(psf.exp_promo_uwg, 0) AS exp_promo_uwg,
 psf.bnc_prom_total,
 psf.bnc_prom_brand_pl,
 fact_c.exp_delivered_nopromo_uwg,
 fact_c.exp_delivered_promo_uwg,
  CASE
  WHEN psf.prom_id IN (1, 100, 110, 120)
  THEN COALESCE(fact2.valid_data_flg_cd, 0) * psf.bnc_prom_total
  ELSE COALESCE(fact2.valid_data_flg_cd, 0) * psf.bnc_prom_brand_pl
  END AS exp_delivered,
  CASE
  WHEN psf.prom_id IN (1, 100, 110, 120)
  THEN COALESCE(psf.exp_total_uwg, 0)
  ELSE COALESCE(psf.exp_promo_uwg, 0)
  END AS expected_uwg,
  CASE
  WHEN psf.prom_id IN (1, 100, 110, 120)
  THEN psf.bnc_prom_total
  ELSE psf.bnc_prom_brand_pl
  END AS data_expected,
  CASE
  WHEN psf.prom_id IN (1, 100, 110, 120)
  THEN fact_c.exp_delivered_nopromo_uwg
  ELSE fact_c.exp_delivered_promo_uwg
  END AS exp_delivered_uwg,
 COALESCE(fact_c.delivered_uwg, 0) AS delivered_uwg
FROM (SELECT CAT1.client_id,
   fact1.liam_parnt_clnt_cat_id,
   fact1.prom_id,
   SUM(CAT1.bnc_prom_total * fact1.valid_data_flg_cd) AS exp_delivered_nopromo_uwg,
   SUM(CAT1.bnc_prom_brand_pl * fact1.valid_data_flg_cd) AS exp_delivered_promo_uwg,
   SUM(fact1.valid_data_flg_cd) AS delivered_uwg
  FROM (SELECT F.client_id,
     F.assort_cat_sid,
     SUBSTR(CAST(SUBSTR(ASS.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS
     liam_parnt_clnt_cat_id,
     SUBSTR(CAST(ASS.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
     F.promotion_brand_id AS prom_id,
     'J' AS valid_data_flg,
     1 AS valid_data_flg_cd,
     MAX(P.period_id) AS per_id
    FROM ldl_p_lew_core_ac.v_market_familygroup_1 AS F
     INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS P ON F.period_sid = P.period_sid
     INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_1 AS ASS ON F.client_id = ASS.client_id AND F.region_sid
         = ASS.region_sid AND F.assort_cat_sid = ASS.assort_cat_sid
     INNER JOIN ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_1 AS LU ON F.client_id = LU.client_id AND ASS.assort_region_cat_id =
       LU.liam_clnt_cat_id
    WHERE F.turnover_val > 0
    GROUP BY F.client_id,
     F.assort_cat_sid,
     liam_parnt_clnt_cat_id,
     liam_clnt_cat_id,
     prom_id) AS fact1
   INNER JOIN ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_1 AS CAT1 ON fact1.client_id = CAT1.client_id AND fact1.liam_clnt_cat_id
      = CAT1.liam_clnt_cat_id
  GROUP BY CAT1.client_id,
   fact1.liam_parnt_clnt_cat_id,
   fact1.prom_id) AS fact_c
 INNER JOIN (SELECT F0.client_id,
   F0.assort_cat_sid,
   SUBSTR(CAST(SUBSTR(ASS0.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id
   ,
   SUBSTR(CAST(ASS0.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
   F0.promotion_brand_id AS prom_id,
   'J' AS valid_data_flg,
   1 AS valid_data_flg_cd,
   MAX(P0.period_id) AS per_id
  FROM ldl_p_lew_core_ac.v_market_familygroup_1 AS F0
   INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS P0 ON F0.period_sid = P0.period_sid
   INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_1 AS ASS0 ON F0.client_id = ASS0.client_id AND F0.region_sid
       = ASS0.region_sid AND F0.assort_cat_sid = ASS0.assort_cat_sid
  WHERE F0.turnover_val > 0
  GROUP BY F0.client_id,
   F0.assort_cat_sid,
   liam_parnt_clnt_cat_id,
   liam_clnt_cat_id,
   prom_id) AS fact2 ON fact_c.client_id = fact2.client_id AND fact_c.liam_parnt_clnt_cat_id = fact2.liam_parnt_clnt_cat_id
     AND fact_c.prom_id = fact2.prom_id
 INNER JOIN ldl_p_lew_mart_cm.v_lil_period_1 AS PER ON fact2.per_id = PER.per_id
 RIGHT JOIN (SELECT DISTINCT MC.client_id,
   MC.liam_clnt_cat_id,
   MC.liam_chld_cat_desc,
   MC.liam_chld_cat_desc_en,
    SUBSTR(MC.liam_clnt_cat_id, 1, 15) || '005000000000' AS liam_clnt_parnt_cat_id,
   MC.liam_parnt_cat_desc,
   MC.liam_parnt_cat_desc_en,
   PROM.prom_id,
   MC.bnc_prom_total,
   MC.bnc_prom_brand_pl,
   exps.exp_total_uwg,
   exps.exp_promo_uwg
  FROM ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_1 AS MC
   INNER JOIN ldl_p_lew_mart_cm.v_lil_promotion_1 AS PROM ON TRUE
   INNER JOIN (SELECT client_id,
     liam_parnt_cat_desc,
     SUM(bnc_prom_total) AS exp_total_uwg,
     SUM(bnc_prom_brand_pl) AS exp_promo_uwg
    FROM ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_1
    GROUP BY client_id,
     liam_parnt_cat_desc) AS exps ON TRIM(MC.liam_parnt_cat_desc) = TRIM(exps.liam_parnt_cat_desc)) AS psf ON fact2.client_id
     = psf.client_id AND fact2.liam_clnt_cat_id = psf.liam_clnt_cat_id AND fact2.prom_id = psf.prom_id;

