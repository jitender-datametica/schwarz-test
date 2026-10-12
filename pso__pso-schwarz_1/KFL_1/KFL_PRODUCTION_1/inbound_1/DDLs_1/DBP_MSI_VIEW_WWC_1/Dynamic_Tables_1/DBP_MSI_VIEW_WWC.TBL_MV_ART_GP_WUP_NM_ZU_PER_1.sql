   CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.TBL_MV_ART_GP_WUP_NM_ZU_PER_1
   (
	MANDANT_ID,
	ART_ID,
	GP_ID,
	WUP_ID,
	NB_ID,
	DAT_VON,
	DAT_BIS,
	EK_NETTO_BNK,
	EK_MEP,
	EINSTANDSPREIS,
	LOGISTIKKOSTENZUSCHLAG
	) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
	AS  
   SELECT 
   v01.mandant_id, 
   v01.art_id, 
   v01.gp_id, 
   v01.wup_id,
   v01.nb_id,
   v03.dat_von,
   v03.dat_bis,
   v03.ek_netto_bnk,
   v03.ek_mep,
   v03.einstandspreis,
   v03.logistikkostenzuschlag,						 
   FROM dbp_view.v_art_gp_nm_zu_per_1 v01
   INNER JOIN
(
    SELECT mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    logistikkostenzuschlag
	FROM dbp_view.v_art_gp_wup_zu_per_1
	WHERE wup_id > -1
) v03
ON v01.mandant_id= v03.mandant_id
AND v01.wup_id = v03.wup_id
AND v01.gp_id = v03.gp_id
AND v01.art_id  =  v03.art_id 
AND v03.dat_von +1 BETWEEN v01.dat_von AND v01.dat_bis

	UNION ALL

    SELECT 
    v01.mandant_id, 
    v01.art_id, 
    v01.gp_id, 
    v01.wup_id,
    v01.nb_id,
    v04.dat_von,
    v04.dat_bis,
    v04.ek_netto_bnk,
    v04.ek_mep,
    v04.einstandspreis,
    v04.logistikkostenzuschlag,						 
    FROM dbp_view.v_art_gp_nm_zu_per_1 v01
    INNER JOIN
    (

	SELECT mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    ek_netto_bnk,
    ek_mep, 
    einstandspreis,
    logistikkostenzuschlag
	FROM dbp_view.v_art_gp_wup_zu_per_1
	WHERE wup_id = -1
) v04
ON v01.mandant_id =  v04.mandant_id 
AND v01.gp_id  =  v04.gp_id 
AND v01.art_id =  v04.art_id 
AND v04.dat_von +1 BETWEEN v01.dat_von AND v01.dat_bis;