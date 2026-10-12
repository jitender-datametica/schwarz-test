CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_NB_2(
	NB_ID,
	NB_BEZ
) AS SELECT
    nb_id,
    nb_bez
FROM dbp_view.v_nb_2;