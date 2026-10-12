CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_IMMO_KOSTENRECHNUNG
AS
   SELECT
  kr.mandant_id,
   kr.krk_id,
   pcpc.pc_hiertyp_id,
   pcpc.pc_lv2,
   MAX(pcpc.pc_bez2) AS max_pc_bez2,
   pcpc.pc_lv3,
   MAX(pcpc.pc_bez3) AS max_pc_bez3,
   kaka.ka_lv2,
   MAX(kaka.ka_bez2) AS max_ka_bez2,
   kaka.ka_lv3,
   MAX(kaka.ka_bez3) AS max_ka_bez3,
   kaka.ka_lv4,
   MAX(kaka.ka_bez4) AS max_ka_bez4,
   kaka.ka_lv5,
   MAX(kaka.ka_bez5) AS max_ka_bez5,
   kaka.ka_lv6,
   MAX(kaka.ka_bez6) AS max_ka_bez6,
   kr.kj_ker_mo_id                                   AS kjmo,
   kr.kostenart_id                                   AS kostenart,
   COALESCE(ka.kostenart_altnv_id,ka.kostenart_id,0) AS konto_iks,
   COALESCE(ks.kostenart_bez, 'Konto '||konto_iks)   AS konto_bez,
   SUM(CASE WHEN kr.plan_fg = 0 THEN kr.euro_betrag ELSE NULL END)                           AS IST_EUR,
   SUM(CASE WHEN kr.plan_fg = 1 AND kr.planvariante_id= 0 THEN kr.euro_betrag ELSE NULL END)                           AS PLAN_EUR,
   SUM(krvj.euro_betrag)                             AS VJ_EUR,
   'EUR'::CHAR(3) AS wrg_id
   FROM dbp_msi_view_ivs.mv_kostenrechnung kr

   JOIN dbp_msi_view_ivs.mv_pc_pc_grp_denorm pcpc
   ON kr.krk_id = pcpc.krk_id AND kr.mandant_id = pcpc.mandant_id AND kr.pc_id = pcpc.pc_lv11
   LEFT JOIN dbp_msi_v_view.v_ka_ka_grp_denorm kaka
   ON kr.mandant_id=kaka.mandant_id AND kr.krk_id=kaka.krk_id AND kr.kostenart_id=kaka.ka_lv11
   LEFT JOIN dbp_msi_view_ivs.mv_kostenrechnung  krvj
   ON kr.krk_id = krvj.krk_id AND kr.mandant_id = krvj.mandant_id AND kr.pc_id=krvj.pc_id AND kr.system_id=krvj.system_id
   AND kr.kostenart_id=krvj.kostenart_id AND kr.plan_fg=krvj.plan_fg AND kr.planvariante_id=krvj.planvariante_id
   AND (kr.kj_ker_mo_id - 100) = krvj.kj_ker_mo_id AND krvj.plan_fg=0
   LEFT JOIN dbp_view.v_kostenart_spr_zu  ks
   ON kr.mandant_id=ks.mandant_id AND kr.krk_id=ks.krk_id AND kr.system_id=ks.system_id
   AND kr.kostenart_id=ks.kostenart_id AND ks.spr_id=COALESCE(22,24)
   LEFT JOIN dbp_view.v_kostenart  ka
   ON kr.mandant_id=ka.mandant_id AND kr.krk_id=ka.krk_id AND kr.system_id=ka.system_id
   AND kr.kostenart_id=ka.kostenart_id

   JOIN (
   SELECT DISTINCT akt_gj,
   kjmo
   FROM dbp_view.v_monat
   WHERE akt_gj=0
   GROUP BY akt_gj, kjmo
   ) zeit
   ON kr.kj_ker_mo_id=zeit.kjmo

   WHERE (pcpc.pc_hiertyp_id = 1 AND CONTAINS( pcpc.pc_lv2, 'IMMO'))
   OR (pcpc.pc_hiertyp_id = 1 AND CONTAINS( pcpc.pc_lv3, '-EH'))

   GROUP BY
   kr.mandant_id
   ,kr.krk_id
   ,pcpc.pc_hiertyp_id
   ,pcpc.pc_lv2
   ,pcpc.pc_lv3
   ,kaka.ka_lv2
   ,kaka.ka_lv3
   ,kaka.ka_lv4
   ,kaka.ka_lv5
   ,kaka.ka_lv6
   ,kr.kj_ker_mo_id
   ,kostenart
   ,konto_iks
   ,konto_bez;