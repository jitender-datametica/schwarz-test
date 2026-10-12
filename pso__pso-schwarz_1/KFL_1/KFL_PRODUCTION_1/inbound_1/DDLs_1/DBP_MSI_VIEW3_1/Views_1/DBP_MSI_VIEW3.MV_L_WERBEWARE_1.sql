CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_WERBEWARE_1
(
mandant_id
, werbeware_id
)
AS
   SELECT
   mandant_id, werbeware_id
   FROM dbp_view.v_l_werbeware_1;