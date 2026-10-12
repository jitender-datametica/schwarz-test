CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEIL_DET_GRUND_ZU_1
(
sb_grund_id
,mandant_id
,detailnote_id
)
AS
   SELECT
   sb_grund_id, mandant_id, detailnote_id
   FROM dbp_view.v_sb_beurteil_det_grund_zu_1  v01;