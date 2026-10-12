CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SW_ATTRIBUT_1
(
sw_attribut_id
,sw_attribut_bez
)
AS
   SELECT
   sw_attribut_id, sw_attribut_bez
   FROM dbp_view.v_l_sw_attribut_1;