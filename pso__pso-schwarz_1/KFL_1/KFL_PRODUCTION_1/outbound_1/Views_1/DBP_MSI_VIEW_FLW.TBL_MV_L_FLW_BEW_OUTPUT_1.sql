CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_flw_bew_output_1 (mandant_id, bde_vorgang_id, werk_id,
beleg_gruppe_id, in_art_id, in_art_nr, art_bez, flw_beleg_typ_id, status_mb, spr_id) AS SELECT V01.mandant_id,
 V01.bde_vorgang_id,
 V01.werk_id,
 V01.beleg_gruppe_id,
 V01.flw_art_id AS in_art_id,
 V02.flw_art_nr AS in_art_nr,
 V03.art_bez,
 V01.flw_beleg_typ_id,
 V01.status_mb,
 V03.spr_id
FROM kfl_production_dbp_view.v_flw_bew_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_spr_zu_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.flw_art_id = V03.flw_art_id
   
WHERE V01.flw_beleg_typ_id = 'WE'
 AND V01.beleg_gruppe_id IN ('C', 'D')
 AND V01.status_mb <> ''
 AND V01.mandant_id IN (1, 2);