CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_kondit_vorgang_1 AS SELECT V01.mandant_id,
 V01.beleg_kondition_id,
 V01.beleg_kondition_pos_id,
 V01.beleg_konditionsart_id,
 V03.werk_id,
 V03.loesch_id,
 V03.best_beleg_pos_id,
 V03.best_beleg_id,
 V03.flw_art_id AS in_art_id,
 V04.flw_lief_id AS in_lief_id,
 V01.wrg_id,
 V05.dat_lief_wunsch,
 V100.default_wrg,
 V01.betrag_beleg_kondition
FROM kfl_production_dbp_view.v_flw_kondit_vorgang_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_kondit_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.beleg_kondition_id
      = V02.beleg_kondition_id AND V01.beleg_kondition_pos_id = V02.best_beleg_pos_id AND V01.beleg_konditionsart_id =
   V02.beleg_konditionsart_id
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_det_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.best_beleg_pos_id
     = V03.best_beleg_pos_id AND V02.best_beleg_id = V03.best_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_1 AS V04 ON V02.mandant_id = V04.mandant_id AND V02.best_beleg_id =
   V04.best_beleg_id
 INNER JOIN kfl_production_dbp_view.v_flw_lief_einteilung_1 AS V05 ON V02.best_beleg_id = V05.best_beleg_id AND V02.best_beleg_pos_id
     = V05.best_beleg_pos_id AND V02.mandant_id = V05.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id IN (1, 2);