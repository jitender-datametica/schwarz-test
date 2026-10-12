create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_WBS_AKTION_NON_STD_WEIGHTS(
	MANDANT_ID,
	WERBE_TYP_ID,
	KJWO,
	DAT_QUELLE,
	DAT_ZIEL,
	DAT_VON_ORIG,
	DAT_BIS_ORIG,
	GEWICHTUNG_PRZ
) as
-- 20210916| SPEC0093956 | mayko | Initial view |
-- 20220719| SPEC0158746 | richternic | zwei neue Spalten 
-- 20230207| SPEC0185076 | richternic | umbenennung der Spalten 
SELECT 
	v01.mandant_id
    ,v01.werbe_typ_id
 	,v01.kjwo
 	,v01.dat_quelle
 	,v01.dat_ziel
    ,v01.dat_von_orig
    ,v01.dat_bis_orig
    ,v01.gewichtung_prz
FROM DBP_MSI_DATA.ts_wbs_aktion_non_std_weights v01;