CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_L_LEISTUNGSART_2(
	MANDANT_ID,
	CO_LEISTUNGSART_ID
) AS
-- 2022-09-13, AP0133256_SPEC0166769, dknop, initial
    SELECT
   mandant_id, co_leistungsart_id
   FROM dbp_view.v_in_l_leistungsart_2
;