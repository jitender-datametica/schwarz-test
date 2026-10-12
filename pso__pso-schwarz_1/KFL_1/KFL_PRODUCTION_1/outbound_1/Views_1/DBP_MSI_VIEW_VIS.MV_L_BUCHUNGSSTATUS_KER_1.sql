CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_buchungsstatus_ker_1 AS SELECT B.akt_buchungs_schluss AS
 akt_bs,
 B.akt_fruehinfo1 AS akt_fi1,
 B.akt_fruehinfo2 AS akt_fi2,
 B.kj_ker_mo_id,
 B.buchungs_schluss_akt AS bs_0,
 B.buchungs_schluss_vm AS bs_1,
 B.buchungs_schluss_vvm AS bs_2,
 B.dat_fruehinfo1 AS dat_fi1,
 B.dat_fruehinfo2 AS dat_fi2,
 B.dat_buchungs_schluss AS dat_bs,
 B.akt_gj_buchungs_schluss,
 MAX(CASE
   WHEN M0.spr_id = 22
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez,
 MAX(CASE
   WHEN M0.spr_id = 22
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_de,
 MAX(CASE
   WHEN M0.spr_id = 124
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_cz,
 MAX(CASE
   WHEN M0.spr_id = 90
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_pl,
 MAX(CASE
   WHEN M0.spr_id = 108
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_sk,
 MAX(CASE
   WHEN M0.spr_id = 65
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_hr,
 MAX(CASE
   WHEN M0.spr_id = 95
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_ro,
 MAX(CASE
   WHEN M0.spr_id = 18
   THEN CAST(M0.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_0_bez_bg,
 MAX(CASE
   WHEN M1.spr_id = 22
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez,
 MAX(CASE
   WHEN M1.spr_id = 22
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_de,
 MAX(CASE
   WHEN M1.spr_id = 124
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_cz,
 MAX(CASE
   WHEN M1.spr_id = 90
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_pl,
 MAX(CASE
   WHEN M1.spr_id = 108
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_sk,
 MAX(CASE
   WHEN M1.spr_id = 65
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_hr,
 MAX(CASE
   WHEN M1.spr_id = 95
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_ro,
 MAX(CASE
   WHEN M1.spr_id = 18
   THEN CAST(M1.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_1_bez_bg,
 MAX(CASE
   WHEN M2.spr_id = 22
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez,
 MAX(CASE
   WHEN M2.spr_id = 22
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_de,
 MAX(CASE
   WHEN M2.spr_id = 124
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_cz,
 MAX(CASE
   WHEN M2.spr_id = 90
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_pl,
 MAX(CASE
   WHEN M2.spr_id = 108
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_sk,
 MAX(CASE
   WHEN M2.spr_id = 65
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_hr,
 MAX(CASE
   WHEN M2.spr_id = 95
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_ro,
 MAX(CASE
   WHEN M2.spr_id = 18
   THEN CAST(M2.mo_bez AS STRING)
   ELSE NULL
   END) AS bs_2_bez_bg
FROM kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS B
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS M0 ON MOD(B.buchungs_schluss_akt, 100) = M0.mo_id
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS M1 ON MOD(B.buchungs_schluss_vm, 100) = M1.mo_id
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS M2 ON MOD(B.buchungs_schluss_vvm, 100) = M2.mo_id
GROUP BY akt_bs,
 akt_fi1,
 akt_fi2,
 B.kj_ker_mo_id,
 bs_0,
 bs_1,
 bs_2,
 dat_fi1,
 dat_fi2,
 dat_bs,
 B.akt_gj_buchungs_schluss;