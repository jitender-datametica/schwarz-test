CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SB_BEURTEIL_DETAIL_2
(
mandant_id
,beurteilung_detail_id
--,beurteilung_bereich_id
,detail_nr
)
AS
   SELECT
   mandant_id, beurteilung_detail_id, detail_nr
   FROM dbp_view.v_l_sb_beurteil_detail_2  v01;