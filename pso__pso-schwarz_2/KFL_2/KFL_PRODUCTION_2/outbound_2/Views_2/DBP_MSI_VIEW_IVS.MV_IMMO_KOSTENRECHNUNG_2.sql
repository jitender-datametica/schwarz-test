CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_immo_kostenrechnung_2 AS SELECT KR.mandant_id,
 KR.krk_id,
 PCPC.pc_hiertyp_id,
 PCPC.pc_lv2,
 MAX(PCPC.pc_bez2) AS max_pc_bez2,
 PCPC.pc_lv3,
 MAX(PCPC.pc_bez3) AS max_pc_bez3,
 KAKA.ka_lv2,
 MAX(KAKA.ka_bez2) AS max_ka_bez2,
 KAKA.ka_lv3,
 MAX(KAKA.ka_bez3) AS max_ka_bez3,
 KAKA.ka_lv4,
 MAX(KAKA.ka_bez4) AS max_ka_bez4,
 KAKA.ka_lv5,
 MAX(KAKA.ka_bez5) AS max_ka_bez5,
 KAKA.ka_lv6,
 MAX(KAKA.ka_bez6) AS max_ka_bez6,
 KR.kj_ker_mo_id AS kjmo,
 KR.kostenart_id AS kostenart_2,
 COALESCE(CAST(KA.kostenart_altnv_id AS BIGNUMERIC), CAST(KA.kostenart_id AS BIGNUMERIC), 0) AS konto_iks,
 COALESCE(KS.kostenart_bez, 'Konto_2 ' || CAST(COALESCE(CAST(KA.kostenart_altnv_id AS BIGNUMERIC), CAST(KA.kostenart_id AS BIGNUMERIC)
     , 0) AS STRING)) AS konto_bez,
 SUM(CASE
   WHEN KR.plan_fg = 0
   THEN KR.euro_betrag
   ELSE NULL
   END) AS ist_eur,
 SUM(CASE
   WHEN KR.plan_fg = 1 AND CAST(KR.planvariante_id AS FLOAT64) = 0
   THEN KR.euro_betrag
   ELSE NULL
   END) AS plan_eur,
 SUM(KRVJ.euro_betrag) AS vj_eur,
 SUBSTR('EUR', 1, 3) AS wrg_id
FROM kfl_production_dbp_msi_view_ivs.mv_kostenrechnung_2 AS KR
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_pc_pc_grp_denorm_2 AS PCPC ON KR.krk_id = PCPC.krk_id AND KR.mandant_id =
    PCPC.mandant_id AND KR.pc_id = PCPC.pc_lv11
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ka_ka_grp_denorm_2 AS KAKA ON KR.mandant_id = KAKA.mandant_id AND KR.krk_id =
    KAKA.krk_id AND KR.kostenart_id = KAKA.ka_lv11
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_kostenrechnung_2 AS KRVJ ON KR.krk_id = KRVJ.krk_id AND KR.mandant_id = KRVJ
          .mandant_id AND KR.pc_id = KRVJ.pc_id AND KR.system_id = KRVJ.system_id AND KR.kostenart_id = KRVJ.kostenart_id
        AND KR.plan_fg = KRVJ.plan_fg AND KR.planvariante_id = KRVJ.planvariante_id AND KR.kj_ker_mo_id - 100 = KRVJ.kj_ker_mo_id
     AND KRVJ.plan_fg = 0
 LEFT JOIN kfl_production_dbp_view.v_kostenart_spr_zu_2 AS KS ON KR.mandant_id = KS.mandant_id AND KR.krk_id = KS.krk_id
    AND KR.system_id = KS.system_id AND KR.kostenart_id = KS.kostenart_id AND KS.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_kostenart_2 AS KA ON KR.mandant_id = KA.mandant_id AND KR.krk_id = KA.krk_id AND KR.system_id
     = KA.system_id AND KR.kostenart_id = KA.kostenart_id
 INNER JOIN (SELECT akt_gj,
   kjmo
  FROM kfl_production_dbp_view.v_monat_2
  WHERE akt_gj = 0
  GROUP BY akt_gj,
   kjmo) AS zeit_2 ON KR.kj_ker_mo_id = zeit.kjmo
WHERE PCPC.pc_hiertyp_id = 1 AND STRPOS(PCPC.pc_lv2, 'IMMO') <> 0
 OR PCPC.pc_hiertyp_id = 1 AND STRPOS(PCPC.pc_lv3, '-EH') <> 0
GROUP BY KR.mandant_id,
 KR.krk_id,
 PCPC.pc_hiertyp_id,
 PCPC.pc_lv2,
 PCPC.pc_lv3,
 KAKA.ka_lv2,
 KAKA.ka_lv3,
 KAKA.ka_lv4,
 KAKA.ka_lv5,
 KAKA.ka_lv6,
 kjmo,
 kostenart_2,
 konto_iks,
 konto_bez;