CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ABT_SPR_ZU_1
AS
   SELECT abt_id, MAX(CASE WHEN spr_id = 22 THEN abt_bez  END)      AS abt_bez, MAX(CASE WHEN spr_id = 22 THEN abt_bez  END)      AS abt_bez_de, MAX(CASE WHEN spr_id = 124 THEN abt_bez  END)      AS abt_bez_cz, MAX(CASE WHEN spr_id = 90 THEN abt_bez  END)      AS abt_bez_pl, MAX(CASE WHEN spr_id = 108 THEN abt_bez  END)      AS abt_bez_sk, MAX(CASE WHEN spr_id = 65 THEN abt_bez  END)      AS abt_bez_hr, MAX(CASE WHEN spr_id = 95 THEN abt_bez  END)       AS abt_bez_ro, MAX(CASE WHEN spr_id = 18 THEN abt_bez  END)      AS abt_bez_bg



   FROM dbp_view.v_abt_spr_zu_1
   WHERE arthiertyp_id = 2
   GROUP BY 1;