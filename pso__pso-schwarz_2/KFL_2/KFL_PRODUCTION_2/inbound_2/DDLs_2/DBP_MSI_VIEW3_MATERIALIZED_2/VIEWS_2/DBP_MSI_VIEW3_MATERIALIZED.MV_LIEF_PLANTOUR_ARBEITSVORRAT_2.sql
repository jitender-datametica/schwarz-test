create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LIEF_PLANTOUR_ARBEITSVORRAT_2(
	MANDANT_ID,
	LAGERNUMMER_ID,
	LIEF_PAL_TYP_ID,
	WERBEWARE_ID,
	LIEF_BELEG_ID,
	LIEF_TYP_ID,
	DAT_LIEF_SOLL,
	AV_HERKUNFT_ID,
	WUP_ID,
	NB_ID,
	PLANTOUR_ID,
	VP_FG,
	STP_FAKTOR_TOUR,
	ANZ_STP,
	DAT_AENDERUNG,
	ANZAHL_PACKSTUECK
) as
--2022-04-06,AP0128105,SPEC0150931  dknop, initial
-- 2023-12-18, dknop, INC7856312, AND lpa.DAT_LIEF_SOLL = bl.DAT_LIEF_SOLL for better performance
SELECT 
 bl.mandant_id
,bl.lagernummer_id
,bl.lief_pal_typ_id
,bl.werbeware_id
,bl.lief_beleg_id
,bl.lief_typ_id
,bl.dat_lief_soll
,lpa.av_herkunft_id
,lpa.wup_id
,lpa.nb_id
,lpa.plantour_id
,lpa.vp_fg
,lpa.stp_faktor_tour
,lpa.anz_stp
,lpa.dat_aenderung
,bl.anzahl_packstueck 
FROM dbp_view.v_lief_plantour_arbeitsvorrat_2 lpa
JOIN dbp_view.v_besch_lief_2 bl 
ON lpa.mandant_id = bl.mandant_id
AND lpa.lief_beleg_id = bl.lief_beleg_id
-- avoid duplicates due to re_2-use of LIEF_BELEG_ID in BG:
--AND lpa.DAT_AENDERUNG BETWEEN bl.DAT_LIEF_SOLL  - 365 AND bl.DAT_LIEF_SOLL +30
AND lpa.dat_lief_soll=bl.dat_lief_soll;