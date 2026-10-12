CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sec_security_role_1 AS SELECT SRO.security_role_id,
 SRO.security_role_desc,
  CASE
  WHEN sda.fbo_vl_vt = 1
  THEN SRO.fbo_vl_vt
  ELSE 0
  END AS fbo_vl_vt,
  CASE
  WHEN sda.ges_all_mc = 1
  THEN SRO.ges_all_mc
  ELSE 0
  END AS ges_all_mc,
  CASE
  WHEN sda.ges_all_mc_bges = 1
  THEN SRO.ges_all_mc_bges
  ELSE 0
  END AS ges_all_mc_bges,
  CASE
  WHEN sda.ges_all_mc_vges = 1
  THEN SRO.ges_all_mc_vges
  ELSE 0
  END AS ges_all_mc_vges,
  CASE
  WHEN sda.ges_vt_oc_filiale = 1
  THEN SRO.ges_vt_oc_filiale
  ELSE 0
  END AS ges_vt_oc_filiale,
  CASE
  WHEN sda.ges_vt_oc_vl = 1
  THEN SRO.ges_vt_oc_vl
  ELSE 0
  END AS ges_vt_oc_vl,
  CASE
  WHEN sda.ges_vt_oc_vt = 1
  THEN SRO.ges_vt_oc_vt
  ELSE 0
  END AS ges_vt_oc_vt,
  CASE
  WHEN sda.ges_vt_oc_wg = 1
  THEN SRO.ges_vt_oc_wg
  ELSE 0
  END AS ges_vt_oc_wg,
  CASE
  WHEN sda.ges_vw_oc_persona = 1
  THEN SRO.ges_vw_oc_persona
  ELSE 0
  END AS ges_vw_oc_persona,
  CASE
  WHEN sda.ges_zd_oc_bt = 1
  THEN SRO.ges_zd_oc_bt
  ELSE 0
  END AS ges_zd_oc_bt,
  CASE
  WHEN sda.ges_zd_oc_immoleiter = 1
  THEN SRO.ges_zd_oc_immoleiter
  ELSE 0
  END AS ges_zd_oc_immoleiter,
  CASE
  WHEN sda.ges_zd_oc_wa_leiter = 1
  THEN SRO.ges_zd_oc_wa_leiter
  ELSE 0
  END AS ges_zd_oc_wa_leiter,
  CASE
  WHEN sda.ges_zd_oc_wb_leiter = 1
  THEN SRO.ges_zd_oc_wb_leiter
  ELSE 0
  END AS ges_zd_oc_wb_leiter,
  CASE
  WHEN sda.ges_zd_oc_we_leiter = 1
  THEN SRO.ges_zd_oc_we_leiter
  ELSE 0
  END AS ges_zd_oc_we_leiter,
  CASE
  WHEN sda.int_all_mc = 1
  THEN SRO.int_all_mc
  ELSE 0
  END AS int_all_mc,
  CASE
  WHEN sda.int_ek_oc_ek = 1
  THEN SRO.int_ek_oc_ek
  ELSE 0
  END AS int_ek_oc_ek,
  CASE
  WHEN sda.int_ek_rc_ek = 1
  THEN SRO.int_ek_rc_ek
  ELSE 0
  END AS int_ek_rc_ek,
  CASE
  WHEN sda.int_vt_oc_vt = 1
  THEN SRO.int_vt_oc_vt
  ELSE 0
  END AS int_vt_oc_vt,
  CASE
  WHEN sda.int_vt_oc_vt_wg = 1
  THEN SRO.int_vt_oc_vt_wg
  ELSE 0
  END AS int_vt_oc_vt_wg,
  CASE
  WHEN sda.int_vt_rc_vt = 1
  THEN SRO.int_vt_rc_vt
  ELSE 0
  END AS int_vt_rc_vt,
  CASE
  WHEN sda.int_vw_oc_finanzen = 1
  THEN SRO.int_vw_oc_finanzen
  ELSE 0
  END AS int_vw_oc_finanzen,
  CASE
  WHEN sda.int_vw_oc_personal = 1
  THEN SRO.int_vw_oc_personal
  ELSE 0
  END AS int_vw_oc_personal,
  CASE
  WHEN sda.int_vw_rc_vw = 1
  THEN SRO.int_vw_rc_vw
  ELSE 0
  END AS int_vw_rc_vw,
  CASE
  WHEN sda.int_zd_oc_immo = 1
  THEN SRO.int_zd_oc_immo
  ELSE 0
  END AS int_zd_oc_immo,
  CASE
  WHEN sda.int_zd_oc_logistik = 1
  THEN SRO.int_zd_oc_logistik
  ELSE 0
  END AS int_zd_oc_logistik,
  CASE
  WHEN sda.int_zd_rc_zd = 1
  THEN SRO.int_zd_rc_zd
  ELSE 0
  END AS int_zd_rc_zd,
  CASE
  WHEN sda.karten_app = 1
  THEN SRO.karten_app
  ELSE 0
  END AS karten_app,
  CASE
  WHEN sda.land_all_mc = 1
  THEN SRO.land_all_mc
  ELSE 0
  END AS land_all_mc,
  CASE
  WHEN sda.land_ek_oc_ek = 1
  THEN SRO.land_ek_oc_ek
  ELSE 0
  END AS land_ek_oc_ek,
  CASE
  WHEN sda.land_ek_rc_ek = 1
  THEN SRO.land_ek_rc_ek
  ELSE 0
  END AS land_ek_rc_ek,
  CASE
  WHEN sda.land_vt_oc_vt = 1
  THEN SRO.land_vt_oc_vt
  ELSE 0
  END AS land_vt_oc_vt,
  CASE
  WHEN sda.land_vt_oc_vt_wg = 1
  THEN SRO.land_vt_oc_vt_wg
  ELSE 0
  END AS land_vt_oc_vt_wg,
  CASE
  WHEN sda.land_vt_rc_vt = 1
  THEN SRO.land_vt_rc_vt
  ELSE 0
  END AS land_vt_rc_vt,
  CASE
  WHEN sda.land_vw_oc_finanzen = 1
  THEN SRO.land_vw_oc_finanzen
  ELSE 0
  END AS land_vw_oc_finanzen,
  CASE
  WHEN sda.land_vw_oc_personal = 1
  THEN SRO.land_vw_oc_personal
  ELSE 0
  END AS land_vw_oc_personal,
  CASE
  WHEN sda.land_vw_rc_vw = 1
  THEN SRO.land_vw_rc_vw
  ELSE 0
  END AS land_vw_rc_vw,
  CASE
  WHEN sda.land_zd_oc_immo = 1
  THEN SRO.land_zd_oc_immo
  ELSE 0
  END AS land_zd_oc_immo,
  CASE
  WHEN sda.land_zd_oc_logistik = 1
  THEN SRO.land_zd_oc_logistik
  ELSE 0
  END AS land_zd_oc_logistik,
  CASE
  WHEN sda.land_zd_rc_zd = 1
  THEN SRO.land_zd_rc_zd
  ELSE 0
  END AS land_zd_rc_zd,
  CASE
  WHEN sda.lidl_plus_all = 1
  THEN SRO.lidl_plus_all
  ELSE 0
  END AS lidl_plus_all,
  CASE
  WHEN sda.lidl_plus_int = 1
  THEN SRO.lidl_plus_int
  ELSE 0
  END AS lidl_plus_int,
  CASE
  WHEN sda.lidl_plus_land = 1
  THEN SRO.lidl_plus_land
  ELSE 0
  END AS lidl_plus_land,
  CASE
  WHEN sda.qv_ges_all_mqv = 1
  THEN SRO.qv_ges_all_mqv
  ELSE 0
  END AS qv_ges_all_mqv,
  CASE
  WHEN sda.qv_ges_all_mqv_bges = 1
  THEN SRO.qv_ges_all_mqv_bges
  ELSE 0
  END AS qv_ges_all_mqv_bges,
  CASE
  WHEN sda.qv_ges_all_mqv_vges = 1
  THEN SRO.qv_ges_all_mqv_vges
  ELSE 0
  END AS qv_ges_all_mqv_vges,
  CASE
  WHEN sda.qv_ges_vl_oqv_bt = 1
  THEN SRO.qv_ges_vl_oqv_bt
  ELSE 0
  END AS qv_ges_vl_oqv_bt,
  CASE
  WHEN sda.qv_ges_vl_oqv_fv = 1
  THEN SRO.qv_ges_vl_oqv_fv
  ELSE 0
  END AS qv_ges_vl_oqv_fv,
  CASE
  WHEN sda.qv_ges_vl_oqv_vl = 1
  THEN SRO.qv_ges_vl_oqv_vl
  ELSE 0
  END AS qv_ges_vl_oqv_vl,
  CASE
  WHEN sda.qv_ges_vl_oqv_vt = 1
  THEN SRO.qv_ges_vl_oqv_vt
  ELSE 0
  END AS qv_ges_vl_oqv_vt,
  CASE
  WHEN sda.qv_ges_vl_oqv_wg = 1
  THEN SRO.qv_ges_vl_oqv_wg
  ELSE 0
  END AS qv_ges_vl_oqv_wg,
  CASE
  WHEN sda.qv_int_all_mqv = 1
  THEN SRO.qv_int_all_mqv
  ELSE 0
  END AS qv_int_all_mqv,
  CASE
  WHEN sda.qv_int_ek_oqv_ek = 1
  THEN SRO.qv_int_ek_oqv_ek
  ELSE 0
  END AS qv_int_ek_oqv_ek,
  CASE
  WHEN sda.qv_int_ek_rqv_ek = 1
  THEN SRO.qv_int_ek_rqv_ek
  ELSE 0
  END AS qv_int_ek_rqv_ek,
  CASE
  WHEN sda.qv_int_vl_oqv_logistik = 1
  THEN SRO.qv_int_vl_oqv_logistik
  ELSE 0
  END AS qv_int_vl_oqv_logistik,
  CASE
  WHEN sda.qv_int_vl_oqv_vt = 1
  THEN SRO.qv_int_vl_oqv_vt
  ELSE 0
  END AS qv_int_vl_oqv_vt,
  CASE
  WHEN sda.qv_int_vl_oqv_vt_wg = 1
  THEN SRO.qv_int_vl_oqv_vt_wg
  ELSE 0
  END AS qv_int_vl_oqv_vt_wg,
  CASE
  WHEN sda.qv_int_vl_rqv_vl = 1
  THEN SRO.qv_int_vl_rqv_vl
  ELSE 0
  END AS qv_int_vl_rqv_vl,
  CASE
  WHEN sda.qv_land_all_mqv = 1
  THEN SRO.qv_land_all_mqv
  ELSE 0
  END AS qv_land_all_mqv,
  CASE
  WHEN sda.qv_land_ek_oqv_ek = 1
  THEN SRO.qv_land_ek_oqv_ek
  ELSE 0
  END AS qv_land_ek_oqv_ek,
  CASE
  WHEN sda.qv_land_ek_rqv_ek = 1
  THEN SRO.qv_land_ek_rqv_ek
  ELSE 0
  END AS qv_land_ek_rqv_ek,
  CASE
  WHEN sda.qv_land_vl_oqv_logistik = 1
  THEN SRO.qv_land_vl_oqv_logistik
  ELSE 0
  END AS qv_land_vl_oqv_logistik,
  CASE
  WHEN sda.qv_land_vl_oqv_vt = 1
  THEN SRO.qv_land_vl_oqv_vt
  ELSE 0
  END AS qv_land_vl_oqv_vt,
  CASE
  WHEN sda.qv_land_vl_oqv_vt_wg = 1
  THEN SRO.qv_land_vl_oqv_vt_wg
  ELSE 0
  END AS qv_land_vl_oqv_vt_wg,
  CASE
  WHEN sda.qv_land_vl_rqv_vl = 1
  THEN SRO.qv_land_vl_rqv_vl
  ELSE 0
  END AS qv_land_vl_rqv_vl,
  CASE
  WHEN sda.qv_qv_quick_view = 1
  THEN SRO.qv_qv_quick_view
  ELSE 0
  END AS qv_qv_quick_view
FROM ldl_p_lew_mart_msi.t_sec_sec_role_acl_1 AS SRO
 INNER JOIN (SELECT MAX(CASE
     WHEN dashboard_name = 'fbo_vl_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS fbo_vl_vt,
   MAX(CASE
     WHEN dashboard_name = 'ges_all_mc'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_all_mc,
   MAX(CASE
     WHEN dashboard_name = 'ges_all_mc_bges'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_all_mc_bges,
   MAX(CASE
     WHEN dashboard_name = 'ges_all_mc_vges'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_all_mc_vges,
   MAX(CASE
     WHEN dashboard_name = 'ges_vt_oc_filiale'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_vt_oc_filiale,
   MAX(CASE
     WHEN dashboard_name = 'ges_vt_oc_vl'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_vt_oc_vl,
   MAX(CASE
     WHEN dashboard_name = 'ges_vt_oc_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_vt_oc_vt,
   MAX(CASE
     WHEN dashboard_name = 'ges_vt_oc_wg'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_vt_oc_wg,
   MAX(CASE
     WHEN dashboard_name = 'ges_vw_oc_persona'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_vw_oc_persona,
   MAX(CASE
     WHEN dashboard_name = 'ges_zd_oc_bt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_zd_oc_bt,
   MAX(CASE
     WHEN dashboard_name = 'ges_zd_oc_immoleiter'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_zd_oc_immoleiter,
   MAX(CASE
     WHEN dashboard_name = 'ges_zd_oc_wa_leiter'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_zd_oc_wa_leiter,
   MAX(CASE
     WHEN dashboard_name = 'ges_zd_oc_wb_leiter'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_zd_oc_wb_leiter,
   MAX(CASE
     WHEN dashboard_name = 'ges_zd_oc_we_leiter'
     THEN dashboard_active_fg
     ELSE 0
     END) AS ges_zd_oc_we_leiter,
   MAX(CASE
     WHEN dashboard_name = 'int_all_mc'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_all_mc,
   MAX(CASE
     WHEN dashboard_name = 'int_ek_oc_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_ek_oc_ek,
   MAX(CASE
     WHEN dashboard_name = 'int_ek_rc_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_ek_rc_ek,
   MAX(CASE
     WHEN dashboard_name = 'int_vt_oc_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_vt_oc_vt,
   MAX(CASE
     WHEN dashboard_name = 'int_vt_oc_vt_wg'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_vt_oc_vt_wg,
   MAX(CASE
     WHEN dashboard_name = 'int_vt_rc_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_vt_rc_vt,
   MAX(CASE
     WHEN dashboard_name = 'int_vw_oc_finanzen'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_vw_oc_finanzen,
   MAX(CASE
     WHEN dashboard_name = 'int_vw_oc_personal'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_vw_oc_personal,
   MAX(CASE
     WHEN dashboard_name = 'int_vw_rc_vw'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_vw_rc_vw,
   MAX(CASE
     WHEN dashboard_name = 'int_zd_oc_immo'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_zd_oc_immo,
   MAX(CASE
     WHEN dashboard_name = 'int_zd_oc_logistik'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_zd_oc_logistik,
   MAX(CASE
     WHEN dashboard_name = 'int_zd_rc_zd'
     THEN dashboard_active_fg
     ELSE 0
     END) AS int_zd_rc_zd,
   MAX(CASE
     WHEN dashboard_name = 'karten_app'
     THEN dashboard_active_fg
     ELSE 0
     END) AS karten_app,
   MAX(CASE
     WHEN dashboard_name = 'land_all_mc'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_all_mc,
   MAX(CASE
     WHEN dashboard_name = 'land_ek_oc_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_ek_oc_ek,
   MAX(CASE
     WHEN dashboard_name = 'land_ek_rc_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_ek_rc_ek,
   MAX(CASE
     WHEN dashboard_name = 'land_vt_oc_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_vt_oc_vt,
   MAX(CASE
     WHEN dashboard_name = 'land_vt_oc_vt_wg'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_vt_oc_vt_wg,
   MAX(CASE
     WHEN dashboard_name = 'land_vt_rc_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_vt_rc_vt,
   MAX(CASE
     WHEN dashboard_name = 'land_vw_oc_finanzen'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_vw_oc_finanzen,
   MAX(CASE
     WHEN dashboard_name = 'land_vw_oc_personal'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_vw_oc_personal,
   MAX(CASE
     WHEN dashboard_name = 'land_vw_rc_vw'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_vw_rc_vw,
   MAX(CASE
     WHEN dashboard_name = 'land_zd_oc_immo'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_zd_oc_immo,
   MAX(CASE
     WHEN dashboard_name = 'land_zd_oc_logistik'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_zd_oc_logistik,
   MAX(CASE
     WHEN dashboard_name = 'land_zd_rc_zd'
     THEN dashboard_active_fg
     ELSE 0
     END) AS land_zd_rc_zd,
   MAX(CASE
     WHEN dashboard_name = 'lidl_plus_all'
     THEN dashboard_active_fg
     ELSE 0
     END) AS lidl_plus_all,
   MAX(CASE
     WHEN dashboard_name = 'lidl_plus_int'
     THEN dashboard_active_fg
     ELSE 0
     END) AS lidl_plus_int,
   MAX(CASE
     WHEN dashboard_name = 'lidl_plus_land'
     THEN dashboard_active_fg
     ELSE 0
     END) AS lidl_plus_land,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_all_mqv'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_all_mqv,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_all_mqv_bges'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_all_mqv_bges,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_all_mqv_vges'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_all_mqv_vges,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_vl_oqv_bt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_vl_oqv_bt,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_vl_oqv_fv'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_vl_oqv_fv,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_vl_oqv_vl'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_vl_oqv_vl,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_vl_oqv_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_vl_oqv_vt,
   MAX(CASE
     WHEN dashboard_name = 'qv_ges_vl_oqv_wg'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_ges_vl_oqv_wg,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_all_mqv'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_all_mqv,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_ek_oqv_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_ek_oqv_ek,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_ek_rqv_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_ek_rqv_ek,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_vl_oqv_logistik'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_vl_oqv_logistik,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_vl_oqv_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_vl_oqv_vt,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_vl_oqv_vt_wg'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_vl_oqv_vt_wg,
   MAX(CASE
     WHEN dashboard_name = 'qv_int_vl_rqv_vl'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_int_vl_rqv_vl,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_all_mqv'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_all_mqv,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_ek_oqv_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_ek_oqv_ek,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_ek_rqv_ek'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_ek_rqv_ek,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_vl_oqv_logistik'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_vl_oqv_logistik,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_vl_oqv_vt'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_vl_oqv_vt,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_vl_oqv_vt_wg'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_vl_oqv_vt_wg,
   MAX(CASE
     WHEN dashboard_name = 'qv_land_vl_rqv_vl'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_land_vl_rqv_vl,
   MAX(CASE
     WHEN dashboard_name = 'qv_qv_quick_view'
     THEN dashboard_active_fg
     ELSE 0
     END) AS qv_qv_quick_view
  FROM ldl_p_lew_mart_msi.v_sec_role_acl_dash_act_1 AS SDX) AS sda ON TRUE;