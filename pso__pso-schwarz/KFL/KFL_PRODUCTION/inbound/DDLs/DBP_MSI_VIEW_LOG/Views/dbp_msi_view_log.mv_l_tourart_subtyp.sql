CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TOURART_SUBTYP(
	TOURART_SUBTYP_ID)
--2021.12.14, dknop, AP0073899, SPEC0091861, initial
-- 10-05-2022, AP0125093, dknop,removing mandant_id

AS
   SELECT
    --mandant_id
   tourart_subtyp_id
   FROM dbp_view.v_l_tourart_subtyp
   GROUP BY tourart_subtyp_id
;