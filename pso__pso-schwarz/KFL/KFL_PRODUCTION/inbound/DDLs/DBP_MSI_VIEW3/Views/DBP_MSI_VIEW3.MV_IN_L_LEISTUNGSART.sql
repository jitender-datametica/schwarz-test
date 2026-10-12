CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_L_LEISTUNGSART
(
mandant_id
,co_leistungsart_id
)
AS
   SELECT
   mandant_id, co_leistungsart_id
   FROM dbp_view.v_in_l_leistungsart
;