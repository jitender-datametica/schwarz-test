CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_els_leergut (barcode_leergut, mandant_id, wup_id, bon_dat
, wrg_id, bon_tmsp, bon_nr, system_bez, system_typ_bez, system_hersteller_bez, bon_zeile, kl_art_id, plu_gruppe, menge,
bon_zeilen_wert) AS SELECT EK.barcode_leergut,
 EK.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 EK.bon_dat,
 krs.nach_wrg_id AS wrg_id,
 EK.bon_tmsp,
 EK.bon_nr,
 EK.system_bez,
 EK.system_typ_bez,
 EK.system_hersteller_bez,
 EP.bon_zeile,
 EP.kl_art_id,
 EP.plu_gruppe,
 EP.menge,
  EP.bon_zeilen_wert * krs.umrechnungskurs AS bon_zeilen_wert
FROM kfl_production_dbp_v_ods.v_els_leergut_kopf AS EK
 INNER JOIN kfl_production_dbp_v_ods.v_els_leergut_position AS EP ON EK.mandant_id = EP.mandant_id AND EK.barcode_leergut
    = EP.barcode_leergut
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON EK.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON EK.mandant_id = WUP.mandant_id AND EK.wup_id = WUP.wup_id;