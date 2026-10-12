CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BELOS_ADRESSE_WUP_ZU_2(
	MANDANT_ID,
	BELOS_ADRESSE_ID,
	WUP_ID,
	NB_ID
) AS
-- 2022-05-24,AP0112140,SPEC0155506, dknop, initial
SELECT
 mandant_id
,belos_adresse_id
,wup_id
,nb_id

FROM dbp_view.v_ts_belos_adresse_wup_zu_2;