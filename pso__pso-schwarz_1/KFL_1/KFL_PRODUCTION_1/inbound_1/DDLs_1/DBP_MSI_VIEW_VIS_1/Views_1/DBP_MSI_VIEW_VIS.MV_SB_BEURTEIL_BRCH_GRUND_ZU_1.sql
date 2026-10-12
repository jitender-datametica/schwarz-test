CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEIL_BRCH_GRUND_ZU_1
(
sb_grund_id
,mandant_id
,bereichsnote_id
)
AS
   SELECT
   sb_grund_id, mandant_id, bereichsnote_id
   FROM dbp_view.v_sb_beurteil_brch_grund_zu_1  v01;