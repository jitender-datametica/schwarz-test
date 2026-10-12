create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_IN_BESCH_LIEF_DET(
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	MANDANT_ID,
	DAT_LIEF_SOLL,
	IN_VERKAUFSORGANISATION_ID,
	WERK_ID,
	LIEF_POS_TYP_ID,
	IN_ART_ID,
	CHARGE_ID,
	IN_VW_ID,
	DAT_MAT_BEREITSTLLG,
	MENGE_LIEF_IST_BME,
	VERK_MENGE_EINH_ID,
	NETTOGEW,
	MENGE_LIEF_IST_LME,
	WRG_ID,
	VORLAGE_BELEG_ID
) as
SELECT
    lief_beleg_id,
    lief_beleg_pos_id,
    v01.mandant_id,
    dat_lief_soll,
    in_verkaufsorganisation_id,
    werk_id,
    lief_pos_typ_id,
    in_art_id,
    charge_id,
    in_vw_id,
    dat_mat_bereitstllg,
    MAX(menge_lief_ist_bme) AS menge_lief_ist_bme,
    verk_menge_einh_id,
    MAX(nettogew) AS nettogew,
    MAX(menge_lief_ist_lme) AS menge_lief_ist_lme,
    wrg_id,
    vorlage_beleg_id
FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_IN_BESCH_LIEF_DET v01
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v07
JOIN dbp_view.v_mandant_wrg_typ_zu v08 ON v01.mandant_id = v08.mandant_id
AND v07.wrg_typ_id = v08.wrg_typ_id
        
-- Daher Gruppierung ueber Belege, Positionen, Artikel ... und die max-Werte nehmen
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    16,
    17;