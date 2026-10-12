CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_BEREICH_SPR_ZU_2
   AS 
   SELECT
   v01.wg_hierarchie_id AS ber_id,
   v02.wg_hierarchie_bez AS ber_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v02.spr_id
   FROM dbp_view.v_wg_hierarchie_zu_per_2 v01
   INNER JOIN dbp_view.v_wg_hierarchie_spr_zu_2 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.wg_hierarchie_ebene_id = v01.wg_hierarchie_ebene_id
   AND v02.wg_hierarchie_id = v01.wg_hierarchie_id
   AND v02.arthiertyp_id = v01.arthiertyp_id
   WHERE v01.mandant_id > 1
   AND v01.arthiertyp_id = 10
   AND v01.wg_hierarchie_ebene_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;