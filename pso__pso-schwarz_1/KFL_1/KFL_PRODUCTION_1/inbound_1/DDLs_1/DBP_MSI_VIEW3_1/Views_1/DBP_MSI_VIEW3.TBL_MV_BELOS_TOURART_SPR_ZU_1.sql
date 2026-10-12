CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_BELOS_TOURART_SPR_ZU_1
AS
   SELECT
   v01.mandant_id, v01.belos_tourart_id, v01.spr_id, v01.belos_tourart_bez

   FROM dbp_view.v_belos_tourart_spr_zu_1 v01
   ;