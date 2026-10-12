CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_handling_unit_rekl_1 (handling_unit_id, art_id, mandant_id,
handling_unit_pos_id, dat_buch, dat_erfasst, menge_bme, tour_id, wup_id, nb_id, vz_wup_id, lis_rekl_grund_id,
lis_rekl_status_id, versandstelle_id, wrg_typ_id, vk_brutto, umrechnungskurs) AS SELECT V01.handling_unit_id,
 V01.art_id,
 V01.mandant_id,
 V01.handling_unit_pos_id,
 V01.dat_buch,
 V01.dat_erfasst,
 V01.menge_bme,
 V01.tour_id,
 V06.aktuell_wup_id AS wup_id,
 - 111 AS nb_id,
 V01.vz_wup_id,
 V01.lis_rekl_grund_id,
 V01.lis_rekl_status_id,
 V01.versandstelle_id,
 V05.wrg_typ_id,
 v02.vk_brutto,
 V04.umrechnungskurs
FROM kfl_production_dbp_view.v_handling_unit_rekl_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V06 ON V01.mandant_id = V06.mandant_id AND V01.wup_id = V06.wup_id AND (V06
      .nb_id IN (2, 0, - 111) AND V06.wup_id > 0 OR V06.nb_id = - 1 AND V06.wup_id = 0)
 INNER JOIN (SELECT art_id,
   mandant_id,
   MAX(vk_brutto) AS vk_brutto
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per_1
  WHERE dat_bis = DATE '9999-12-31'
   AND (mandant_id = 1 AND preistyp_id = 0 AND pm_id = 1 AND vw_id IN (1, 2, 3, 6) OR mandant_id <> 1 AND preistyp_id =
         0 AND pm_id = 1 AND vw_id IN (10, 90))
  GROUP BY art_id,
   mandant_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id
 INNER JOIN (SELECT mandant_id,
   wrg_id
  FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03
  WHERE wrg_typ_id = 1) AS v03 ON v02.mandant_id = v03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs_1 AS V04 ON v03.wrg_id = V04.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V05 ON v02.mandant_id = V05.mandant_id;