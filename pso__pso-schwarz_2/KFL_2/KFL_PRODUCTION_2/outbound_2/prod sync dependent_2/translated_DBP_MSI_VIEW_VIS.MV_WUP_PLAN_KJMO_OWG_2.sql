CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 (mandant_id, nb_id, wup_id, kjmo, owg_id,
wrg_id, umsatz_netto_plan, abschriften_netto_operativ_plan) AS SELECT WPK.mandant_id,
 WPK.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 WPK.kjmo,
 WPK.hwg_id AS owg_id,
 krs.nach_wrg_id AS wrg_id,
  WPK.umsatz_netto_plan * krs.umrechnungskurs AS umsatz_netto_plan,
  WPK.abschriften_netto_operativ_plan * krs.umrechnungskurs AS abschriften_netto_operativ_plan
FROM kfl_production_dbp_view.v_wup_plan_kjmo_owg_2 AS WPK
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON WPK.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON WPK.mandant_id = WUP.mandant_id AND WPK.wup_id = WUP.wup_id;