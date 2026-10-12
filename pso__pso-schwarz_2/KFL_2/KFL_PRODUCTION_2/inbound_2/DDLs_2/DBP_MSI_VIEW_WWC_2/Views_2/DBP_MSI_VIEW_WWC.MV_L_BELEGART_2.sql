CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BELEGART_2
(
mandant_id
,system_id
,BLART
)
AS
   SELECT
   v01.mandant_id, v01.system_id, v01.belegart_id AS BLART
   FROM dbp_view.v_l_belegart_2 v01
;