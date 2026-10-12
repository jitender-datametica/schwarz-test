CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AUTODISPOCLUSTER_1 as
   SELECT
   v01.mandant_id, v01.wg_hierarchie_id  AS autodispo_id, v02.wg_hierarchie_bez AS autodispo_bez
   FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
   INNER join dbp_view.v_wg_hierarchie_spr_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wg_hierarchie_id = v02.wg_hierarchie_id
   AND v01.wg_hierarchie_ebene_id = v02.wg_hierarchie_ebene_id
   AND v01.arthiertyp_id = v02.arthiertyp_id
   WHERE v01.arthiertyp_id = 9
   AND v01.mandant_id = 1
   AND  v01.wg_hierarchie_ebene_id = 1
   AND v02.spr_id = 22
   AND v01.dat_bis = '9999-12-31'
   ;