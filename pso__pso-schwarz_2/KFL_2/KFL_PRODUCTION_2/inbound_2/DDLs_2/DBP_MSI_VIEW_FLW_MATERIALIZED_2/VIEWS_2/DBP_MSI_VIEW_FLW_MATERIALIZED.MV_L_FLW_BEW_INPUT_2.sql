create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_BEW_INPUT_2(
	MANDANT_ID,
	BDE_VORGANG_ID,
	WERK_ID,
	BELEG_GRUPPE_ID,
	IN_ART_ID,
	IN_ART_NR,
	ART_BEZ,
	FLW_BELEG_TYP_ID,
	STATUS_MB
) as
SELECT
    mandant_id --, system_id
,
    bde_vorgang_id,
    werk_id,
    beleg_gruppe_id,
    in_art_id,
    in_art_nr,
    art_bez,
    flw_beleg_typ_id,
    status_mb
FROM
    DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_L_FLW_BEW_INPUT_2 v01
    JOIN dbp_msi.akt_msi_user_spr_zu_2 v04 ON v01.spr_id = v04.spr_id;