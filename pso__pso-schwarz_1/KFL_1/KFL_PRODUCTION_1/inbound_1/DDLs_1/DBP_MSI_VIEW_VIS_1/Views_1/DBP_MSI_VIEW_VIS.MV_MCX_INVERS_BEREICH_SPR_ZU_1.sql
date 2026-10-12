CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_INVERS_BEREICH_SPR_ZU_1 as
   -- SPR_1 : KMR/MCX Bereich (Inverse Hierarchie)
   -- 2019.0809 ssch0611 VTC-KMR Redesign (Init)
   -- 2019.0917 ssch0611 : KBEZ(bez_2) added
   -- 2019.1014 ssch0611 : Bugfixing

   SELECT
   invers_ber_id, Max(CASE WHEN spr_id =  22 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez    -- standard (DE)
   , Max(CASE WHEN spr_id =  22 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez, Max(CASE WHEN spr_id = 124 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez_cz, Max(CASE WHEN spr_id = 124 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez_cz, Max(CASE WHEN spr_id = 108 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez_sk, Max(CASE WHEN spr_id = 108 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez_sk, Max(CASE WHEN spr_id =  65 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez_hr, Max(CASE WHEN spr_id =  65 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez_hr, Max(CASE WHEN spr_id =  90 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez_pl, Max(CASE WHEN spr_id =  90 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez_pl, Max(CASE WHEN spr_id =  95 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez_ro, Max(CASE WHEN spr_id =  95 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez_ro, Max(CASE WHEN spr_id =  18 THEN invers_ber_bez ELSE NULL END)    AS invers_ber_bez_bg, Max(CASE WHEN spr_id =  18 THEN invers_ber_bez_2 ELSE NULL END)  AS invers_ber_kbez_bg
   FROM dbp_view.v_mcx_invers_bereich_spr_zu_1

   GROUP BY invers_ber_id;