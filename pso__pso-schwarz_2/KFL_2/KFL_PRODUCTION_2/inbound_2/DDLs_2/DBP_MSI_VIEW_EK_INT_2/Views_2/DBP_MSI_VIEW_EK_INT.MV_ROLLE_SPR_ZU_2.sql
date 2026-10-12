CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ROLLE_SPR_ZU_2
AS
   SELECT
   4 AS Rolle_id, 'Superuser' AS rolle_bez, MAX(CASE WHEN spr_id = 22 THEN 'Superuser'  ELSE NULL END)      AS rolle_bez_de, MAX(CASE WHEN spr_id = 124 THEN 'Superuser' ELSE NULL END)      AS rolle_bez_cz, MAX(CASE WHEN spr_id = 90 THEN 'Superuser'  ELSE NULL END)      AS rolle_bez_pl, MAX(CASE WHEN spr_id = 108 THEN 'Superuser' ELSE NULL END)      AS rolle_bez_sk, MAX(CASE WHEN spr_id = 65 THEN 'Superuser'  ELSE NULL END)      AS rolle_bez_hr, MAX(CASE WHEN spr_id = 95 THEN 'Superuser'  ELSE NULL END)      AS rolle_bez_ro, MAX(CASE WHEN spr_id = 18 THEN 'Superuser'  ELSE NULL END)      AS rolle_bez_bg

   FROM dbp_view.v_mandant_spr_zu_2
   GROUP BY  1
   UNION
   SELECT
   1 AS Rolle_id, 'ZEK_2' AS rolle_bez, MAX(CASE WHEN spr_id = 22 THEN 'ZEK_2'  ELSE NULL END)      AS rolle_bez_de, MAX(CASE WHEN spr_id = 124 THEN 'ZEK_2' ELSE NULL END)      AS rolle_bez_cz, MAX(CASE WHEN spr_id = 90 THEN 'ZEK_2'  ELSE NULL END)      AS rolle_bez_pl, MAX(CASE WHEN spr_id = 108 THEN 'ZEK_2' ELSE NULL END)      AS rolle_bez_sk, MAX(CASE WHEN spr_id = 65 THEN 'ZEK_2'  ELSE NULL END)      AS rolle_bez_hr, MAX(CASE WHEN spr_id = 95 THEN 'ZEK_2'  ELSE NULL END)      AS rolle_bez_ro, MAX(CASE WHEN spr_id = 18 THEN 'ZEK_2'  ELSE NULL END)      AS rolle_bez_bg

   FROM dbp_view.v_mandant_spr_zu_2
   GROUP BY  1
   UNION
   SELECT
   2 AS Rolle_id, 'EKL' AS rolle_bez, MAX(CASE WHEN spr_id = 22 THEN 'EKL'  ELSE NULL END)      AS rolle_bez_de, MAX(CASE WHEN spr_id = 124 THEN 'EKL' ELSE NULL END)      AS rolle_bez_cz, MAX(CASE WHEN spr_id = 90 THEN 'EKL'  ELSE NULL END)      AS rolle_bez_pl, MAX(CASE WHEN spr_id = 108 THEN 'EKL' ELSE NULL END)      AS rolle_bez_sk, MAX(CASE WHEN spr_id = 65 THEN 'EKL'  ELSE NULL END)      AS rolle_bez_hr, MAX(CASE WHEN spr_id = 95 THEN 'EKL'  ELSE NULL END)      AS rolle_bez_ro, MAX(CASE WHEN spr_id = 18 THEN 'EKL'  ELSE NULL END)      AS rolle_bez_bg

   FROM dbp_view.v_mandant_spr_zu_2
   GROUP BY  1
   UNION
   SELECT
   3 AS Rolle_id, 'GF_2' AS rolle_bez, MAX(CASE WHEN spr_id = 22 THEN 'GF_2'  ELSE NULL END)      AS rolle_bez_de, MAX(CASE WHEN spr_id = 124 THEN 'GF_2' ELSE NULL END)      AS rolle_bez_cz, MAX(CASE WHEN spr_id = 90 THEN 'GF_2'  ELSE NULL END)      AS rolle_bez_pl, MAX(CASE WHEN spr_id = 108 THEN 'GF_2' ELSE NULL END)      AS rolle_bez_sk, MAX(CASE WHEN spr_id = 65 THEN 'GF_2'  ELSE NULL END)      AS rolle_bez_hr, MAX(CASE WHEN spr_id = 95 THEN 'GF_2'  ELSE NULL END)      AS rolle_bez_ro, MAX(CASE WHEN spr_id = 18 THEN 'GF_2'  ELSE NULL END)      AS rolle_bez_bg

   FROM dbp_view.v_mandant_spr_zu_2
   GROUP BY  1;