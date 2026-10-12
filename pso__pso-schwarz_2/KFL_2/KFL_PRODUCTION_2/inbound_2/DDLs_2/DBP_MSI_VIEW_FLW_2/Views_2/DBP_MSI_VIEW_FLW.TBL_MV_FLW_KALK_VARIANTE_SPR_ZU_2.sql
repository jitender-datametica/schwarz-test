CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_FLW_KALK_VARIANTE_SPR_ZU_2
   AS 
     SELECT
    v01.mandant_id, v01.kalk_variante_id, v01.spr_id, v01.kalk_variante_bez, v03.mandant_kbez

   FROM dbp_view.v_flw_kalk_variante_spr_zu_2 v01
   JOIN dbp_view.v_mandant_2 v03
   ON v01.mandant_id = v03.mandant_id;