CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_art_spr_zu_1 AS SELECT V01.art_id,
 V01.mandant_id,
 V01.art_bez
FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
   
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V03 ON V01.spr_id = V03.spr_id
WHERE V01.mandant_id IN (1, 2)
 AND V02.dat_bis = DATE '9999-12-31'
 AND V02.arthiertyp_id = 2
 AND V02.wg_id IN (3, 122, 128, 134, 135, 136, 137, 138, 139, 141, 142, 144, 145, 146, 147, 158, 159, 184, 186, 232, 233
   , 234, 235, 236, 237, 238, 239, 331, 242, 243, 244, 245, 246);