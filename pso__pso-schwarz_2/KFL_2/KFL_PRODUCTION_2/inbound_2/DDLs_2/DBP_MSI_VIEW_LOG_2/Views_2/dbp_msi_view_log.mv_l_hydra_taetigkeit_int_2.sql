CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_HYDRA_TAETIGKEIT_INT_2(
	TAETIGKEIT_INT_ID,
	TAETIGKEIT_INT_BEZ
) AS
--2023-06-30, AP0145540,SPEC0182434, dknop, initial 
SELECT
 taetigkeit_int_id
,taetigkeit_int_bez
FROM dbp_view.v_l_hydra_taetigkeit_int_2
GROUP BY
 taetigkeit_int_id
,taetigkeit_int_bez
 UNION
SELECT
 -1,
 'N/A'
;