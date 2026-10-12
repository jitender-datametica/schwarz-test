CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_REKL_2
(
	DAT,
	ART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	REKLAMATIONSGRUND_ID,
	REKL_VK_BRUTTO,
	REKL_VK_MENGE,
	GP_ID,
	MHD,
	LOS_CHARGE,
	MWST_ID,
	MWST,
	ART_ID_REF,
	KUNDEN_TEXT
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
r.dat, 
r.art_id, 
r.mandant_id, 
r.wup_id, 
r.nb_id, 
r.reklamationsgrund_id, 
r.VK_Brutto_re, 
r.VK_Menge_re, 
r.gp_id, 
r.mhd, 
r.los_charge, 
a.mwst_id, 
m.mwst, 
art_id_ref, 
kunden_text

FROM dbp_view.v_rekl_2  r
INNER JOIN dbp_view.v_art_2 a
ON a.art_id=r.art_id
AND a.mandant_id = r.mandant_id
INNER JOIN dbp_view.v_mwst_per_2 m
ON a.mwst_id = m.mwst_id
AND a.mandant_id = m.mandant_id
WHERE r.mandant_id = 1
AND r.dat BETWEEN m.dat_von AND m.dat_bis
AND r.bon_storno_fg = 0;