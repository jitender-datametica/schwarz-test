CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_L_LEISTUNGSART_1
(
mandant_id
,co_leistungsart_id
)
AS
   SELECT
   mandant_id, co_leistungsart_id
   FROM dbp_view.v_in_l_leistungsart_1
;