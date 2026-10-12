CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_BERICHTS_POS_IT_RWI AS
--17.09.2013 AL neu erstellt analog mv_berichts_pos_it_rwi

   SELECT
   berichts_position_it_id AS  berichts_position_it_rwi_id

   FROM dbp_view.v_l_berichts_pos_it
;