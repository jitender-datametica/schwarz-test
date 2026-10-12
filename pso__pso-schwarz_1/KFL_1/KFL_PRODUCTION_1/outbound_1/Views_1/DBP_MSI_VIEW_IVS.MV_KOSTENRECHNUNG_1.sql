CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_kostenrechnung_1 AS SELECT KR.mandant_id,
 KR.pc_id,
 KR.kj_ker_mo_id,
 KR.kostenart_id,
 KR.plan_fg,
 KR.planvariante_id,
  KR.kostenrechnung_betrag * ku.umrechnungskurs AS euro_betrag,
 ku.umrechnungskurs,
 KR.kostenrechnung_betrag,
 KR.wrg_id,
 KR.system_id,
 KR.krk_id,
 KR.buchungskreis_id_ker,
 KR.gj,
 KR.buchungsperiode_id
FROM kfl_production_dbp_view.v_kostenrechnung_1 AS KR
 INNER JOIN (SELECT von_wrg_id,
   umrechnungskurs
  FROM kfl_production_dbp_view.v_kurs_1 AS U
  WHERE kurstyp_id = 3
   AND dat_bis = DATE '9999-12-31') AS ku ON KR.wrg_id = ku.von_wrg_id;