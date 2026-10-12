CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_dat_leergut_1 (mandant_id, wup_id, nb_id, dat, wrg_id,
betrag_leergut_zaehlung, betrag_leergut_inventur, td_update, td_insert) AS SELECT LG.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 LG.nb_id,
 LG.dat,
 krs.nach_wrg_id AS wrg_id,
 LG.betrag_leergut_zaehlung,
 LG.betrag_leergut_inventur,
 LG.td_update,
 LG.td_insert
FROM kfl_production_dbp_msi_data.ts_wup_dat_leergut_1 AS LG
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
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON LG.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON LG.mandant_id = WUP.mandant_id AND LG.wup_id = WUP.wup_id;