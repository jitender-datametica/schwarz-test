CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_in_stueckliste_det_2 (mandant_id, stueckliste_id,
stueckliste_pos_id, stueckliste_typ_id, in_art_id, in_art_nr, art_bez, spr_id) AS SELECT V01.mandant_id,
 V01.stueckliste_id,
 V01.stueckliste_pos_id,
 V01.stueckliste_typ_id,
 V01.flw_art_id AS in_art_id,
 V02.flw_art_nr AS in_art_nr,
 V03.art_bez,
 V03.spr_id
FROM kfl_production_dbp_view.v_flw_stueckliste_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_spr_zu_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.flw_art_id = V03.flw_art_id
   
WHERE V01.stueckliste_pos_typ_id IN ('G', 'X')
 AND V01.komponentenmenge > 0.001
 AND V01.mandant_id IN (1, 2);