CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_ART_GP_WUP_RUECKBEWERTUNG_MO_1(
	MANDANT_ID,
	KJMO,
	KJMO_RBW_MSEG,
	ART_ID,
	GP_ID,
	WUP_ID,
	NB_ID,
	DAT_GUELTIG_VON,
	DAT_GUELTIG_BIS,
	DAT_ABZUG,
	WRG_ID,
    KMO_WE_BONUS_ARTGENAU,
	DE_WE_BONUS_ARTGENAU,
    DE_WE_BONUS_KLEP,
	WE_BONUS,
    MENGE,
    DMBTR
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
--11.09.2024, SPEC0262044, Neuanlage
SELECT 
    v01.mandant_id,
    v01.kjmo,
	v03.kjmo AS KJMO_RBW_MSEG,
    v01.art_id,
    v02.gp_id,
    v02.wup_id,
    v02.nb_id,
    v01.dat_gueltig_von,
    v01.dat_gueltig_bis,
    v01.dat_abzug,
    v01.wrg_id,
	(MAX(preis_ek_mep_vor_fwu)-MAX(preis_ek_nettonetto)) *SUM(menge_lagerbew_bme) AS kmo_we_bonus_artgenau,
    (MAX(preis_ek_mep)+MAX(preis_ek_netto_bnk)) *SUM(menge_lagerbew_bme) AS de_we_bonus_artgenau,
    (MAX(preis_ek_einstandspreis)+MAX(preis_ek_netto_bnk)) *SUM(menge_lagerbew_bme) AS de_we_bonus_klep,
	MAX(preis_kmep_einh_o_fwu)*SUM(menge_lagerbew_bme) AS we_bonus,
    SUM(menge_lagerbew_bme)  AS Menge, 
	SUM(betrag_lagerbew) AS DMBTR,
    FROM dbp_msi_v_view.v_art_gp_wup_rueckbewertung_mo_1 v01
INNER JOIN dbp_view.v_art_gp_nm_zu_per_1 v02
ON v01.mandant_id=v02.mandant_id
AND v01.art_id=v02.art_id
AND v01.dat_gueltig_von BETWEEN v02.dat_von AND v02.dat_bis

AND CASE WHEN
  -- Ermittlung ob VK_1 über WUP_1 gejoint werden soll
  v01.WUP_ID =-1
  THEN 
  v01.gp_id=v02.gp_id    
  ELSE    
  v01.gp_id=v02.gp_id
  AND v01.WUP_ID=v02.WUP_ID
END

INNER JOIN dbp_view.v_lagerbew_det_wwc_monat_1 v03
ON v01.mandant_id=v03.mandant_id
AND v01.art_id=v03.art_id
AND v02.wup_id=v03.wup_id
INNER JOIN dbp_view.V_MONAT_1 v08
ON v03.kjmo=v08.kjmo
AND v08.akt_gj BETWEEN '-1' AND '0'

GROUP BY 1,2,3,4,5,6,7,8,9,10,11;