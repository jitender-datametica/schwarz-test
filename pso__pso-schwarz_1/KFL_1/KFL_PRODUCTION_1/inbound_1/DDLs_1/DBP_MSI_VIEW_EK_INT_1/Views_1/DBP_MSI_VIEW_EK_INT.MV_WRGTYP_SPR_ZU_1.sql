CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WRGTYP_SPR_ZU_1
AS
   SELECT
   1 AS wrgtyp_id, 'Länderwährung' AS wrgtyp_bez, MAX(CASE WHEN spr_id = 22 THEN 'Länderwährung' ELSE NULL END)      AS wrgtyp_bez_de, MAX(CASE WHEN spr_id = 124 THEN 'Länderwährung' ELSE NULL END)      AS wrgtyp_bez_cz, MAX(CASE WHEN spr_id = 90 THEN 'Länderwährung'  ELSE NULL END)      AS wrgtyp_bez_pl, MAX(CASE WHEN spr_id = 108 THEN 'Länderwährung' ELSE NULL END)      AS wrgtyp_bez_sk, MAX(CASE WHEN spr_id = 65 THEN 'Länderwährung'  ELSE NULL END)      AS wrgtyp_bez_hr, MAX(CASE WHEN spr_id = 95 THEN 'Länderwährung'  ELSE NULL END)      AS wrgtyp_bez_ro, MAX(CASE WHEN spr_id = 18 THEN 'Länderwährung'  ELSE NULL END)      AS wrgtyp_bez_bg

   FROM dbp_view.v_mandant_spr_zu_1
   GROUP BY  1
   UNION ALL
   SELECT
   2 AS wrgtyp_id, 'Euro' AS wrgtyp_bez, MAX(CASE WHEN spr_id = 22 THEN 'Euro'  ELSE NULL END)      AS wrgtyp_bez_de, MAX(CASE WHEN spr_id = 124 THEN 'Euro' ELSE NULL END)      AS wrgtyp_bez_cz, MAX(CASE WHEN spr_id = 90 THEN 'Euro'  ELSE NULL END)      AS wrgtyp_bez_pl, MAX(CASE WHEN spr_id = 108 THEN 'Euro' ELSE NULL END)      AS wrgtyp_bez_sk, MAX(CASE WHEN spr_id = 65 THEN 'Euro'  ELSE NULL END)      AS wrgtyp_bez_hr, MAX(CASE WHEN spr_id = 95 THEN 'Euro'  ELSE NULL END)      AS wrgtyp_bez_ro, MAX(CASE WHEN spr_id = 18 THEN 'Euro'  ELSE NULL END)      AS wrgtyp_bez_bg

   FROM dbp_view.v_mandant_spr_zu_1
   GROUP BY  1;