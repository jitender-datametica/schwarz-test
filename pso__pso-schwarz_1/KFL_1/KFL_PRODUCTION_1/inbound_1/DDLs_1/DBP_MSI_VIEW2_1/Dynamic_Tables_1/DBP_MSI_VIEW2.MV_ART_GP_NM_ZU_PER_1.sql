CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_GP_NM_ZU_PER_1
(
	ART_ID,
	GP_ID,
	MANDANT_ID,
	WUP_ID,
	AKTUELL_FG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 art_id
,gp_id
,mandant_id
,wup_id
,aktuell_fg
FROM
    (
    SELECT
     art_id
    ,gp_id
    ,mandant_id
    ,wup_id
    ,CASE WHEN dat_bis = '9999-12-31' THEN 'a' ELSE 'h' END AS aktuell_fg
    ,dat_bis
    FROM dbp_view.v_art_gp_nm_zu_per_1
    WHERE mandant_id = 1
    ) v1 QUALIFY SUM(1) OVER (
        PARTITION BY v1.art_id
        ,v1.gp_id
        ,v1.mandant_id
        ,v1.wup_id
        ORDER BY
            v1.dat_bis DESC NULLS LAST ROWS UNBOUNDED PRECEDING
    ) = 1;