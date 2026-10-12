create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_KALK(
	MANDANT_ID,
	SCHNITTLISTE_ID,
	WERK_ID,
	DAT_KALK_AB,
	DAT_KALK_BIS,
	FORTGESCH_KALK_FG,
	KALK_NR,
	KALK_BEZ,
	KALK_KENNZ,
	KALK_VARIANTE_ID,
	PLAN_SOLL_KZ
) as
SELECT
    mandant_id --, system_id
,
    schnittliste_id,
    werk_id,
    dat_kalk_ab,
    dat_kalk_bis,
    fortgesch_kalk_fg,
    kalk_nr,
    kalk_bez,
    kalk_kennz,
    kalk_variante_id,
    plan_soll_kz
FROM
    DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_L_KALK v01
    JOIN dbp_msi.akt_msi_user_spr_zu v06 ON v01.spr_id = v06.spr_id;