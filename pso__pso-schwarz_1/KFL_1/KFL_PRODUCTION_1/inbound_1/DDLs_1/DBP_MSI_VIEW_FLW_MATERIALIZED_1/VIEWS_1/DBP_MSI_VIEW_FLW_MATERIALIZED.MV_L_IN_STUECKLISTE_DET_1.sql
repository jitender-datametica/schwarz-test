create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_STUECKLISTE_DET_1(
	MANDANT_ID,
	STUECKLISTE_ID,
	STUECKLISTE_POS_ID,
	STUECKLISTE_TYP_ID,
	IN_ART_ID,
	IN_ART_NR,
	ART_BEZ
) as
SELECT
     mandant_id --, system_id
,
    stueckliste_id,
    stueckliste_pos_id,
    stueckliste_typ_id,
    in_art_id,
    in_art_nr,
    art_bez
FROM
    DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_L_IN_STUECKLISTE_DET_1 v01
    JOIN dbp_msi.akt_msi_user_spr_zu_1 v04 ON v01.spr_id = v04.spr_id;