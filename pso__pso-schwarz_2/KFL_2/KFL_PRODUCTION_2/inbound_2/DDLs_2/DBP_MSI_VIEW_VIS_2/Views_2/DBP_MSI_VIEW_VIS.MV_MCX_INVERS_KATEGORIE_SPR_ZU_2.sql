CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_INVERS_KATEGORIE_SPR_ZU_2 as
   -- SPR_2 : KMR/MCX Kategorie (Inverse Hierarchie)
   -- 2019.0809 ssch0611 VTC-KMR Redesign (Init)
   -- 2019.0917 ssch0611 : KBEZ(bez_2) added

   SELECT
   invers_kat_id, Max(CASE WHEN spr_id =  22 THEN invers_kat_bez   END)  AS invers_kat_bez    -- standard (DE)
   , Max(CASE WHEN spr_id =  22 THEN invers_kat_bez_2 END)  AS invers_kat_kbez, Max(CASE WHEN spr_id = 124 THEN invers_kat_bez   END)  AS invers_kat_bez_cz, Max(CASE WHEN spr_id = 124 THEN invers_kat_bez_2 END)  AS invers_kat_kbez_cz, Max(CASE WHEN spr_id = 108 THEN invers_kat_bez   END)  AS invers_kat_bez_sk, Max(CASE WHEN spr_id = 108 THEN invers_kat_bez_2 END)  AS invers_kat_kbez_sk, Max(CASE WHEN spr_id =  90 THEN invers_kat_bez   END)  AS invers_kat_bez_pl, Max(CASE WHEN spr_id =  90 THEN invers_kat_bez_2 END)  AS invers_kat_kbez_pl, Max(CASE WHEN spr_id =  65 THEN invers_kat_bez   END)  AS invers_kat_bez_hr, Max(CASE WHEN spr_id =  65 THEN invers_kat_bez_2 END)  AS invers_kat_kbez_hr, Max(CASE WHEN spr_id =  95 THEN invers_kat_bez   END)  AS invers_kat_bez_ro, Max(CASE WHEN spr_id =  95 THEN invers_kat_bez_2 END)  AS invers_kat_kbez_ro, Max(CASE WHEN spr_id =  18 THEN invers_kat_bez   END)  AS invers_kat_bez_bg, Max(CASE WHEN spr_id =  18 THEN invers_kat_bez_2 END)  AS invers_kat_kbez_bg

   FROM dbp_view.v_mcx_invers_kategorie_spr_zu_2

   GROUP BY invers_kat_id;