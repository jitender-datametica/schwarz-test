CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_KONDITIONSGRUPPE(
	mandant_id
	,konditionsgruppe_id
) AS SELECT
	mandant_id
	,konditionsgruppe_id
FROM dbp_view.v_l_konditionsgruppe
WHERE mandant_id = 1;