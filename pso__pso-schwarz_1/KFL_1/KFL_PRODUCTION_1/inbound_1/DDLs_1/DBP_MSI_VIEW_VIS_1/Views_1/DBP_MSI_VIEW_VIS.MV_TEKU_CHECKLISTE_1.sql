CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_CHECKLISTE_1
(
teku_checkliste_id
,teku_checkliste_bez
)
AS
   SELECT
   teku_checkliste_id, teku_checkliste_bez
   FROM dbp_view.v_l_teku_checkliste_1
;