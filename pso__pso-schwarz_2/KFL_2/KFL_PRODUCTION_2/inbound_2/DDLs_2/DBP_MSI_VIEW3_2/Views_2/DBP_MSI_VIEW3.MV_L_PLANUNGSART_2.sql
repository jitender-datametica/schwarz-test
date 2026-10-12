CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_PLANUNGSART_2
-- -- 03.12.2018, mkub1811, AP0027269, neue View
(
mandant_id
,planungsart_id
)
AS
   SELECT
   mandant_id, planungsart_id
   FROM dbp_view.v_l_planungsart_2;