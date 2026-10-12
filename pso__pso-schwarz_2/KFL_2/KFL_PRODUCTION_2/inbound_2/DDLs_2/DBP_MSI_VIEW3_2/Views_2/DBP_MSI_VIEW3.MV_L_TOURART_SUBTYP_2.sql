CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_TOURART_SUBTYP_2
(
mandant_id
,tourart_subtyp_id
)
AS
   SELECT
   mandant_id, tourart_subtyp_id
   FROM dbp_view.v_l_tourart_subtyp_2
;