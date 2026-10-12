CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_HYDRA_TAETIGKEIT_ZU(
	MANDANT_ID,
	PERS_TEILBEREICH_ID,
	TAETIGKEIT_ID,
	TAETIGKEIT_BEZ,
	TAETIGKEIT_TYP_ID,
	TAETIGKEIT_TYP_BEZ,
	TAETIGKEIT_INT_ID,
	TAETIGKEIT_INT_BEZ
) AS
--2023-06-29, AP0145540,SPEC0182434, dknop, initial 
SELECT DISTINCT
 h_tt.mandant_id
,h_tt.pers_teilbereich_id
,h_tt.taetigkeit_id
,COALESCE(h_tt.taetigkeit_bez,'N/A')
,COALESCE(h_tt.taetigkeit_typ_id,NULL)
,CASE WHEN h_tt.taetigkeit_typ_id='Z' THEN 'Zeitlohn'
      WHEN h_tt.taetigkeit_typ_id='D' THEN 'Durchschnitt'
      ELSE NULL END AS taetigkeit_typ_bez
,COALESCE(h_tt.taetigkeit_int_id, -1)
,COALESCE(taetigkeit_int_bez, 'N/A')
FROM  dbp_view.v_hydra_taetigkeit_zu h_tt
LEFT JOIN dbp_view.v_l_hydra_taetigkeit_int l_hti
ON h_tt.taetigkeit_int_id = l_hti.taetigkeit_int_id
AND h_tt.mandant_id = l_hti.mandant_id
;