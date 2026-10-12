CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BUCHUNGSSTATUS_KER_1 as
   -- 2011KW37: Internationalisierung (feste Sprache)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   b.akt_buchungs_schluss      AS akt_bs, b.akt_fruehinfo1               AS akt_fi1, b.akt_fruehinfo2               AS akt_fi2, b.kj_ker_mo_id                 AS kj_ker_mo_id, b.buchungs_schluss_akt     AS bs_0, b.buchungs_schluss_vm      AS bs_1, b.buchungs_schluss_vvm   AS bs_2, b.dat_fruehinfo1         AS dat_fi1, b.dat_fruehinfo2         AS dat_fi2, b.dat_buchungs_schluss     AS dat_bs, b.akt_gj_buchungs_schluss, MAX(CASE WHEN m0.spr_id =  22 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez      --standard=deutsch
   , MAX(CASE WHEN m0.spr_id =  22 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_de   --deutsch
   , MAX(CASE WHEN m0.spr_id = 124 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_cz   --tschechisch
   , MAX(CASE WHEN m0.spr_id =  90 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_pl   --polnisch
   , MAX(CASE WHEN m0.spr_id = 108 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_sk   --slowakisch
   , MAX(CASE WHEN m0.spr_id =  65 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_hr   --kroatisch
   , MAX(CASE WHEN m0.spr_id =  95 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_ro   --rumänisch
   , MAX(CASE WHEN m0.spr_id =  18 THEN CAST(m0.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_0_bez_bg   --bulgarisch
   , MAX(CASE WHEN m1.spr_id =  22 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez      --standard=deutsch
   , MAX(CASE WHEN m1.spr_id =  22 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_de   --deutsch
   , MAX(CASE WHEN m1.spr_id = 124 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_cz   --tschechisch
   , MAX(CASE WHEN m1.spr_id =  90 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_pl   --polnisch
   , MAX(CASE WHEN m1.spr_id = 108 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_sk   --slowakisch
   , MAX(CASE WHEN m1.spr_id =  65 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_hr   --kroatisch
   , MAX(CASE WHEN m1.spr_id =  95 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_ro   --rumänisch
   , MAX(CASE WHEN m1.spr_id =  18 THEN CAST(m1.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_1_bez_bg   --bulgarisch
   , MAX(CASE WHEN m2.spr_id =  22 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez      --standard=deutsch
   , MAX(CASE WHEN m2.spr_id =  22 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_de   --deutsch
   , MAX(CASE WHEN m2.spr_id = 124 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_cz   --tschechisch
   , MAX(CASE WHEN m2.spr_id =  90 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_pl   --polnisch
   , MAX(CASE WHEN m2.spr_id = 108 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_sk   --slowakisch
   , MAX(CASE WHEN m2.spr_id =  65 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_hr   --kroatisch
   , MAX(CASE WHEN m2.spr_id =  95 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_ro   --rumänisch
   , MAX(CASE WHEN m2.spr_id =  18 THEN CAST(m2.mo_bez AS VARCHAR(20)) ELSE NULL END)  AS bs_2_bez_bg   --bulgarisch
   FROM dbp_view.v_l_buchungsstatus_ker_1 b
   INNER JOIN dbp_view.v_monat_spr_zu_1 m0
   ON MOD( b.buchungs_schluss_akt, 100) = m0.mo_id
   INNER JOIN dbp_view.v_monat_spr_zu_1 m1
   ON MOD( b.buchungs_schluss_vm, 100) = m1.mo_id
   INNER JOIN dbp_view.v_monat_spr_zu_1 m2
   ON MOD( b.buchungs_schluss_vvm, 100) = m2.mo_id
   GROUP BY
   b.akt_buchungs_schluss
   ,b.akt_fruehinfo1
   ,b.akt_fruehinfo2
   ,b.kj_ker_mo_id
   ,b.buchungs_schluss_akt
   ,b.buchungs_schluss_vm
   ,b.buchungs_schluss_vvm
   ,b.dat_fruehinfo1
   ,b.dat_fruehinfo2
   ,b.dat_buchungs_schluss
   ,b.akt_gj_buchungs_schluss;