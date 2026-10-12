CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_techn_platz_obl_hist AS SELECT CAST(CASE
   WHEN (ROW_NUMBER() OVER (PARTITION BY obl.techn_platz_id ORDER BY obl.cpr_ext_id IS NULL, obl.cpr_ext_id)) = 1
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS lfdnr,
 obl.techn_platz_id,
 obl.techn_platz_id AS sort_techn_platz_id,
 obl.projekt_id,
 obl.cpr_ext_id,
 obl.mandant_id,
 obl.tp_vl_name,
 obl.tp_vkl_name,
 obl.tp_ol_vermietung,
 obl.tp_bl_kbl_name,
 obl.tp_betreuer_kbl_name,
 obl.tp_betreuer_handy_nr,
 obl.tp_betreuer_hls_name,
 obl.tp_betreuer_elektro_name,
 obl.tp_bl_projekt_name,
 obl.tp_pl_kbl,
 OBLH.tp_vl_name AS tp_vl_name_h,
 OBLH.tp_vkl_name AS tp_vkl_name_h,
 OBLH.tp_ol_vermietung AS tp_ol_vermietung_h,
 OBLH.tp_bl_kbl_name AS tp_bl_kbl_name_h,
 OBLH.tp_betreuer_kbl_name AS tp_betreuer_kbl_name_h,
 OBLH.tp_betreuer_handy_nr AS tp_betreuer_handy_nr_h,
 OBLH.tp_betreuer_hls_name AS tp_betreuer_hls_name_h,
 OBLH.tp_betreuer_elektro_name AS tp_betreuer_elektro_name_h,
 OBLH.tp_bl_projekt_name AS tp_bl_projekt_name_h,
 OBLH.tp_pl_kbl AS tp_pl_kbl_h,
  CASE
  WHEN obl.tp_vl_name = COALESCE(OBLH.tp_vl_name, '')
  THEN 0
  ELSE 1
  END AS tp_vl_name_fgh,
  CASE
  WHEN obl.tp_vkl_name = COALESCE(OBLH.tp_vkl_name, '')
  THEN 0
  ELSE 1
  END AS tp_vkl_name_fgh,
  CASE
  WHEN COALESCE(obl.tp_ol_vermietung, '') = COALESCE(OBLH.tp_ol_vermietung, '')
  THEN 0
  ELSE 1
  END AS tp_ol_vermietung_fgh,
  CASE
  WHEN COALESCE(obl.tp_bl_kbl_name, '') = COALESCE(OBLH.tp_bl_kbl_name, '')
  THEN 0
  ELSE 1
  END AS tp_bl_kbl_name_fgh,
  CASE
  WHEN COALESCE(obl.tp_betreuer_kbl_name, '') = COALESCE(OBLH.tp_betreuer_kbl_name, '')
  THEN 0
  ELSE 1
  END AS tp_betreuer_kbl_name_fgh,
  CASE
  WHEN COALESCE(obl.tp_betreuer_handy_nr, '') = COALESCE(OBLH.tp_betreuer_handy_nr, '')
  THEN 0
  ELSE 1
  END AS tp_betreuer_handy_nr_fgh,
  CASE
  WHEN COALESCE(obl.tp_betreuer_hls_name, '') = COALESCE(OBLH.tp_betreuer_hls_name, '')
  THEN 0
  ELSE 1
  END AS tp_betreuer_hls_name_fgh,
  CASE
  WHEN COALESCE(obl.tp_betreuer_elektro_name, '') = COALESCE(OBLH.tp_betreuer_elektro_name, '')
  THEN 0
  ELSE 1
  END AS tp_betreuer_elektro_name_fgh,
  CASE
  WHEN COALESCE(obl.tp_bl_projekt_name, '') = COALESCE(OBLH.tp_bl_projekt_name, '')
  THEN 0
  ELSE 1
  END AS tp_bl_projekt_name_fgh,
  CASE
  WHEN COALESCE(obl.tp_pl_kbl, '') = COALESCE(OBLH.tp_pl_kbl, '')
  THEN 0
  ELSE 1
  END AS tp_pl_kbl_fgh,
 oblh_dat.dat_extrakt
FROM (SELECT TP.techn_platz_id,
    pr.projekt_id,
    TP.mandant_id,
        TRIM(MA_SPR_ZU_GF.ma_anrede) || ' ' || TRIM(MA_SPR_ZU_GF.ma_vorname) || ' ' || TRIM(MA_SPR_ZU_GF.ma_name) AS
    tp_vl_name,
        TRIM(MA_SPR_ZU_VKL.ma_anrede) || ' ' || TRIM(MA_SPR_ZU_VKL.ma_vorname) || ' ' || TRIM(MA_SPR_ZU_VKL.ma_name) AS
    tp_vkl_name,
    TP2.tp_ol_vermietung,
    TP2.tp_bl_kbl_name,
    TP2.tp_betreuer_kbl_name,
    TP2.tp_betreuer_handy_nr,
    TP2.tp_betreuer_hls_name,
    TP2.tp_betreuer_elektro_name,
    pr.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name,
    pr.pl_be_name AS tp_pl_kbl,
    COALESCE(pr.cpr_ext_id, '') AS cpr_ext_id,
    CURRENT_DATE AS dat_extrakt
   FROM kfl_production_dbp_view.v_techn_platz_per AS TP
    INNER JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per AS TP2 ON TP.techn_platz_id = TP2.techn_platz_id AND
      TP2.dat_bis = DATE '9999-12-31'
    INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per AS TP_S ON TP.techn_platz_id = TP_S.techn_platz_id AND
       TP_S.spr_id = 22 AND TP_S.dat_bis = DATE '9999-12-31'
    LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS WUP_DENORM ON TP.wup_id = WUP_DENORM.wup_id AND TP2.mandant_id
       = WUP_DENORM.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_vkl AS VKL ON WUP_DENORM.vkl_id = VKL.vkl_id AND WUP_DENORM.mandant_id = VKL.mandant_id
      
    LEFT JOIN kfl_production_dbp_view.v_ma_spr_zu AS MA_SPR_ZU_VKL ON VKL.vkl_id = MA_SPR_ZU_VKL.ma_id AND VKL.mandant_id
        = MA_SPR_ZU_VKL.mandant_id AND MA_SPR_ZU_VKL.spr_id = 22
    LEFT JOIN kfl_production_dbp_view.v_gf AS GF ON WUP_DENORM.gf_gbl_vertrieb_id = GF.gf_id AND WUP_DENORM.mandant_id =
      GF.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_ma_spr_zu AS MA_SPR_ZU_GF ON GF.gf_id = MA_SPR_ZU_GF.ma_id AND GF.mandant_id =
       MA_SPR_ZU_GF.mandant_id AND MA_SPR_ZU_GF.spr_id = 22
    LEFT JOIN (SELECT mandant_id,
      techn_platz_id,
      pl_be_name,
      cpr_bl_projekt_bau_einr_name,
      projekt_id,
      cpr_ext_id
     FROM kfl_production_dbp_view.v_cpr_projekt_per AS PR0
     WHERE dat_bis = DATE '9999-12-31'
      AND cpr_systemstatus1_id = 2
      AND cpr_standort IS NOT NULL) AS pr ON TP.techn_platz_id = pr.techn_platz_id AND TP.mandant_id = pr.mandant_id
   WHERE TP.wup_stadt IS NOT NULL
    AND TP.techn_platz_ebene_id = 2
    AND TP.dat_bis = DATE '9999-12-31'
   UNION ALL
   SELECT PR.techn_platz_id,
    PR.projekt_id,
    PR.mandant_id,
    '' AS tp_vl_name,
    '' AS tp_vkl_name,
    '' AS tp_ol_vermietung,
    '' AS tp_bl_kbl_name,
    '' AS tp_betreuer_kbl_name,
    '' AS tp_betreuer_handy_nr,
    '' AS tp_betreuer_hls_name,
    '' AS tp_betreuer_elektro_name,
    PR.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name,
    PR.pl_be_name AS tp_pl_kbl,
    PR.cpr_ext_id,
    CURRENT_DATE AS dat_extrakt
   FROM kfl_production_dbp_view.v_cpr_projekt_per AS PR
    INNER JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per AS PR_S ON PR.projekt_id = PR_S.projekt_id AND PR_S.spr_id
        = 22 AND PR_S.dat_bis = DATE '9999-12-31'
   WHERE PR.cpr_systemstatus1_id = 2
    AND PR.dat_bis = DATE '9999-12-31'
    AND PR.techn_platz_id NOT IN (SELECT techn_platz_id
      FROM kfl_production_dbp_view.v_techn_platz_per AS TP0
      WHERE wup_stadt IS NOT NULL
       AND techn_platz_ebene_id = 2
       AND dat_bis = DATE '9999-12-31')
    AND PR.cpr_standort IS NOT NULL) AS obl
 LEFT JOIN kfl_production_dbp_msi_view_ios.mv_techn_platz_obl_basis_hist AS OBLH ON obl.techn_platz_id = OBLH.techn_platz_id
    AND COALESCE(obl.projekt_id, '') = COALESCE(OBLH.projekt_id, '')
 INNER JOIN (SELECT mandant_id,
   MAX(dat_extrakt) AS dat_extrakt
  FROM kfl_production_dbp_msi_view_ios.mv_techn_platz_obl_basis_hist
  GROUP BY mandant_id) AS oblh_dat ON obl.mandant_id = oblh_dat.mandant_id;