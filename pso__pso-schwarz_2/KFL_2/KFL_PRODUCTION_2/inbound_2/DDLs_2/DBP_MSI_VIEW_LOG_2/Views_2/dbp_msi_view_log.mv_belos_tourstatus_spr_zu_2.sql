CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BELOS_TOURSTATUS_SPR_ZU_2
-- 2021.11.26, dknop, AP0073899, SPEC0091861, initial

AS
SELECT

 v01.belos_tourstatus_id
,v01.belos_tourstatus_bez

FROM dbp_view.v_belos_tourstatus_spr_zu_2  v01

;