CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_wpufib_1 (wup_id, mandant_id, dat_booking, zahlungsmittel_id
, buchungsschluessel_id, aggr_nr, group_nr, record_nr, wrg_id, betrag) AS SELECT WUP.aktuell_wup_id AS wup_id,
 W.mandant_id,
 W.dat_booking,
 W.zahlungsmittel_id,
 W.buchungsschluessel_id,
 W.aggr_nr,
 W.group_nr,
 W.record_nr,
 krs.nach_wrg_id AS wrg_id,
  W.betrag * krs.umrechnungskurs AS betrag
FROM kfl_production_dbp_v_ods.v_ods_wpufib_1 AS W
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON W.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON W.mandant_id = WUP.mandant_id AND W.wup_id = WUP.wup_id;