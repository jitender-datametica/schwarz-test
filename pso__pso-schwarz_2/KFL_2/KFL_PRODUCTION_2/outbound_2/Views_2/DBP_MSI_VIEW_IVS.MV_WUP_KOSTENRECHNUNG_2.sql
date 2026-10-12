CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_wup_kostenrechnung_2 AS SELECT IO.mandant_id,
 IO.immo_objekt_id,
 ker.pc_id,
 ker.wup_id,
 ker.gj,
 ker.kjmo,
 ker.umsatz_ist,
 ker.umsatz_plan,
 ker.wrg_id,
 ker.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_2 AS IO
 LEFT JOIN (SELECT KR.mandant_id,
   KR.pc_id,
   PC.wup_id,
   PC.wup_id AS kerwup_id,
   ZEIT.gj,
   ZEIT.kjmo,
   MWT.wrg_id,
   MWT.wrg_typ_id,
   SUM(CASE
     WHEN KR.plan_fg = 0 AND ka.report_pos = 'UMS'
     THEN CASE
      WHEN MWT.wrg_typ_id = 0
      THEN KR.kostenrechnung_betrag * K.umrechnungskurs
      WHEN MWT.wrg_typ_id = 1
      THEN KR.kostenrechnung_betrag
      ELSE NULL
      END
     ELSE NULL
     END) AS umsatz_ist,
   SUM(CASE
     WHEN KR.plan_fg = 1 AND ka.report_pos = 'UMS'
     THEN CASE
      WHEN MWT.wrg_typ_id = 0
      THEN KR.kostenrechnung_betrag * K.umrechnungskurs
      WHEN MWT.wrg_typ_id = 1
      THEN KR.kostenrechnung_betrag
      ELSE NULL
      END
     ELSE NULL
     END) AS umsatz_plan
  FROM kfl_production_dbp_view.v_kostenrechnung_2 AS KR
   INNER JOIN kfl_production_dbp_view.v_profit_center_2 AS PC ON KR.pc_id = PC.pc_id AND KR.mandant_id = PC.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_monat_2 AS ZEIT_2 ON ZEIT.kjmo = CASE
     WHEN MOD(KR.kj_ker_mo_id, 100) = 13
     THEN KR.kj_ker_mo_id + 89
     ELSE KR.kj_ker_mo_id
     END
   INNER JOIN (SELECT ka_lv11 AS kostenart_id,
     SUBSTR('UMS', 1, 3) AS report_pos
    FROM kfl_production_dbp_msi_v_view.v_ka_ka_grp_denorm_2
    WHERE TRIM(ka_lv1) IN ('K0')
     OR TRIM(ka_lv2) IN ('K0')
     OR TRIM(ka_lv3) IN ('K0')
     OR TRIM(ka_lv4) IN ('K0')
     OR TRIM(ka_lv5) IN ('K0')
     OR TRIM(ka_lv6) IN ('K0')
     OR TRIM(ka_lv7) IN ('K0')
     OR TRIM(ka_lv8) IN ('K0')
     OR TRIM(ka_lv9) IN ('K0')
     OR TRIM(ka_lv10) IN ('K0')
     OR TRIM(ka_lv11) IN ('K0')) AS ka ON KR.kostenart_id = ka.kostenart_id
   INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS MWT ON KR.mandant_id = MWT.mandant_id
   INNER JOIN kfl_production_dbp_view.v_kurs_2 AS K ON KR.wrg_id = K.von_wrg_id AND K.kurstyp_id = 3 AND K.dat_bis =
     DATE '9999-12-31'
  GROUP BY KR.mandant_id,
   KR.pc_id,
   PC.wup_id,
   ZEIT.gj,
   ZEIT.kjmo,
   MWT.wrg_id,
   MWT.wrg_typ_id) AS ker ON IO.immo_objekt_bez = ker.kerwup_id AND IO.mandant_id = ker.mandant_id
WHERE IO.dat_bis = DATE '9999-12-31';