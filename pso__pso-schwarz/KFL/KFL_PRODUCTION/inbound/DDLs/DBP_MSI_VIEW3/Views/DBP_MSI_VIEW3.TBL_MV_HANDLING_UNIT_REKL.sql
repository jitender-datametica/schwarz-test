create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.TBL_MV_HANDLING_UNIT_REKL(
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
	WRG_TYP_ID,
	VK_BRUTTO,
	UMRECHNUNGSKURS
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
   
  
    v06.aktuell_wup_id AS wup_id,
    -111 AS nb_id, 
    v01.vz_wup_id,  
    v01.lis_rekl_grund_id,
    v01.lis_rekl_status_id,
    v01.versandstelle_id,
    v05.wrg_typ_id,
    v02.vk_brutto,
    umrechnungskurs
FROM
    dbp_view.v_handling_unit_rekl v01
     INNER JOIN dbp_view.v_wup v06
   ON v06.mandant_id = v01.mandant_id
   AND v06.wup_id = v01.wup_id
   AND ((v06.nb_id IN (2, 0, -111) AND v06.wup_id > 0) OR (v06.nb_id = -1 AND v06.wup_id = 0))
       
    INNER JOIN (
        SELECT
            art_id,
            mandant_id,
            MAX(vk_brutto) AS vk_brutto 
        FROM
            dbp_view.v_art_pm_vw_zu_per
        WHERE
            dat_bis = '9999-12-31'
            AND 
            (
                (
                    mandant_id = 1
                    AND preistyp_id = 0
                    AND pm_id = 1
                    AND vw_id IN (1, 2, 3, 6)
                )
                OR 
                (
                    mandant_id <> 1
                    AND preistyp_id = 0
                    AND pm_id = 1
                    AND vw_id IN (10, 90)
                )
            )
        GROUP BY
            art_id,
            mandant_id
    ) v02 ON v01.mandant_id = v02.mandant_id
    AND v01.art_id = v02.art_id
    INNER JOIN (
        SELECT
            mandant_id,
            wrg_id
        FROM
            dbp_view.v_mandant_wrg_typ_zu v03
        WHERE
            wrg_typ_id = 1
    ) v03 ON v02.mandant_id = v03.mandant_id
    INNER JOIN dbp_msi_view3.mv_kurs v04 ON v03.wrg_id = v04.von_wrg_id
    JOIN dbp_view.v_mandant_wrg_typ_zu v05 ON v02.mandant_id = v05.mandant_id 
;
