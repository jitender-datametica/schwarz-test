create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VZ_ZUORDNUNG(
	MANDANT_ID,
	VZ_WUP_ID,
	WUP_PLZ,
	ZU_ID,
	WUP_ID,
	NB_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    v01.mandant_id,
    v01.vz_wup_id,
    v01.wup_plz,
    CASE
WHEN v01.wup_plz <20000 OR v01.vz_wup_id=6907 THEN '1'
WHEN v01.wup_plz BETWEEN 20000 AND 59999 THEN '3' ELSE '2'
END AS zu_id,
    v02.wup_id,
    v02.nb_id

FROM
(
SELECT
v01.mandant_id,
    v01.vz_wup_id,
    v01.wup_plz,
    CASE WHEN v01.wup_plz <20000 OR v01.vz_wup_id=6907 THEN '1'
WHEN v01.wup_plz BETWEEN 20000 AND 59999 THEN '3' ELSE '2'
END AS zu_id
FROM dbp_view.v_wup v01
    WHERE vz_wup_id = wup_id AND v01.wup_typ_id = 2 AND v01.nb_id = -111 AND v01.mandant_id = 1
    ) v01
    LEFT OUTER JOIN dbp_view.v_wup v02
    ON v01.vz_wup_id=v02.vz_wup_id AND v01.mandant_id = v02.mandant_id;
