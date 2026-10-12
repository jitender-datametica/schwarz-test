create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.MV_HANDLING_UNIT_REKL_2(
	HANDLING_UNIT_ID,
	ART_ID,
	MANDANT_ID,
	HANDLING_UNIT_POS_ID,
	DAT_BUCH,
	DAT_ERFASST,
	MENGE_BME,
	TOUR_ID,
	WUP_ID,
	NB_ID,
	VZ_WUP_ID,
	LIS_REKL_GRUND_ID,
	LIS_REKL_STATUS_ID,
	VERSANDSTELLE_ID,
	VK_BRUTTO,
	BELOS_ADRESSE_SPEDITION_ID,
	BELOS_ADRESSE_NUM_ID
) as





SELECT
    v01.handling_unit_id,
    v01.art_id,
    v01.mandant_id,
    v01.handling_unit_pos_id,
    v01.dat_buch,
    v01.dat_erfasst,
    v01.menge_bme,
    v01.tour_id,
    v01.wup_id, 
    v01.nb_id,
    v01.vz_wup_id,
    v01.lis_rekl_grund_id,
    v01.lis_rekl_status_id,
    v01.versandstelle_id,
    CASE
        WHEN v06.wrg_typ_id = 0 THEN v01.vk_brutto * umrechnungskurs
        ELSE v01.vk_brutto END AS vk_brutto, 
    
    COALESCE(v021.spedition_tms_gp_id, v03.belos_adresse_spedition_id) AS belos_adresse_spedition_id,
    COALESCE(COALESCE(v02.belos_adresse_num_id, v03.belos_adresse_absender_num_id),'-1')
    
FROM
    DBP_MSI_VIEW3.TBL_MV_HANDLING_UNIT_REKL_2 v01
 LEFT JOIN (
SELECT DISTINCT tms_tour.mandant_id , TRY_CAST(tms_tour.startlager_tms_gp_id AS NUMBER) AS wup_id,
CASE WHEN LEFT(tms_tour.transportation_unit_id_ext,3) = 'SAP' THEN TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) 
ELSE tu.transportation_unit_id END AS tour_id
, tms_tour.dat_tour, CASE WHEN tms_tour.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg ,tms_tour.tms_tourart_detail_id, TMS_TOURSTATUS_ID, tms_tour.spedition_tms_gp_id
FROM dbp_data.tms_tour_2 tms_tour_2
LEFT JOIN ( SELECT mandant_id, transportation_unit_id_ext, KJ_TRANSPORTATION_UNIT, MAX(transportation_unit_id) AS transportation_unit_id 
            FROM dbp_view.v_transportation_unit_2 
            GROUP BY mandant_id, transportation_unit_id_ext, KJ_TRANSPORTATION_UNIT ) tu
    ON tms_tour.mandant_id = tu.mandant_id
    AND tms_tour.transportation_unit_id_ext = tu.transportation_unit_id_ext
WHERE YEAR(tms_tour.DAT_TOUR) >= YEAR(CURRENT_DATE) -2
AND EXISTS (SELECT 1 FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM_2 v022 WHERE tms_tour.dat_tour >= v022.dat_tms_wanko AND tms_tour.mandant_id=v022.mandant_id
AND TRY_CAST(tms_tour.startlager_tms_gp_id AS NUMBER) = v022.wup_id ) ) v021
ON v01.mandant_id = v021.mandant_id
AND v01.vz_wup_id = v021.wup_id
AND v01.tour_id = v021.tour_id
       
LEFT JOIN dbp_view.v_tour_2 v02
       ON  v01.mandant_id = v02.mandant_id
       AND v01.tour_id = v02.tour_id
       AND v01.vz_wup_id = v02.belos_adresse_num_id
       
    LEFT JOIN dbp_view.v_transportation_unit_aktivitaet_2 v03
       ON  v01.mandant_id = v03.mandant_id
       AND v01.tour_id = v03.transportation_unit_id 
       AND v01.vz_wup_id = v03.belos_adresse_absender_num_id
       AND aktivitaet_richtung_id ='2'
              
       JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v06
       ON   v01.wrg_typ_id = v06.wrg_typ_id
;
