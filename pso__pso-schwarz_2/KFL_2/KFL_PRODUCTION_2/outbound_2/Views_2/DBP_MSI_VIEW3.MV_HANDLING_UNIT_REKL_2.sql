

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_handling_unit_rekl_2 (USERID STRING) AS SELECT V01.handling_unit_id
 ,
 V01.art_id,
 V01.mandant_id,
 V01.handling_unit_pos_id,
 V01.dat_buch,
 V01.dat_erfasst,
 V01.menge_bme,
 V01.tour_id,
 V01.wup_id,
 V01.nb_id,
 V01.vz_wup_id,
 V01.lis_rekl_grund_id,
 V01.lis_rekl_status_id,
 V01.versandstelle_id,
  CASE
  WHEN V06.wrg_typ_id = 0
  THEN V01.vk_brutto * V01.umrechnungskurs
  ELSE V01.vk_brutto
  END AS vk_brutto,
 COALESCE(v021.spedition_tms_gp_id, V03.belos_adresse_spedition_id) AS belos_adresse_spedition_id,
 COALESCE(COALESCE(V02.belos_adresse_num_id, V03.belos_adresse_absender_num_id), -1) AS belos_adresse_num_id
FROM kfl_production_dbp_msi_view3.tbl_mv_handling_unit_rekl_2 AS V01
 LEFT JOIN (SELECT DISTINCT TMS_TOUR.mandant_id,
   ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0) AS wup_id,
    CASE
    WHEN LEFT(TMS_TOUR.transportation_unit_id_ext, 3) = 'SAP'
    THEN ROUND(SAFE_CAST(RIGHT(TMS_TOUR.transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR.transportation_unit_id_ext)) -
        6) AS BIGNUMERIC), 0)
    ELSE CAST(t0.transportation_unit_id AS BIGNUMERIC)
    END AS tour_id,
   TMS_TOUR.dat_tour,
    CASE
    WHEN TMS_TOUR.tms_tourtyp_id = 105
    THEN 0
    ELSE 1
    END AS distribution_abr_fg,
   TMS_TOUR.tms_tourart_detail_id,
   TMS_TOUR.tms_tourstatus_id,
   TMS_TOUR.spedition_tms_gp_id
  FROM kfl_production_dbp_data.tms_tour_2 AS TMS_TOUR_2
   LEFT JOIN (SELECT mandant_id,
     transportation_unit_id_ext,
     kj_transportation_unit,
     MAX(transportation_unit_id) AS transportation_unit_id
    FROM kfl_production_dbp_view.v_transportation_unit_2
    GROUP BY mandant_id,
     kj_transportation_unit,
     transportation_unit_id_ext) AS t0 ON TMS_TOUR.mandant_id = t0.mandant_id AND TMS_TOUR.transportation_unit_id_ext =
     t0.transportation_unit_id_ext
  WHERE EXTRACT(YEAR FROM TMS_TOUR.dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
   AND EXISTS (SELECT 1
    FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_2 AS V022
    WHERE TMS_TOUR.dat_tour >= dat_tms_wanko
     AND TMS_TOUR.mandant_id = mandant_id
     AND ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0) = wup_id)) AS v021 ON V01.mandant_id = v021.mandant_id
     AND V01.vz_wup_id = v021.wup_id AND V01.tour_id = v021.tour_id
 LEFT JOIN kfl_production_dbp_view.v_tour_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.tour_id = V02.tour_id AND
   V01.vz_wup_id = V02.belos_adresse_num_id
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.tour_id
      = V03.transportation_unit_id AND V01.vz_wup_id = V03.belos_adresse_absender_num_id AND V03.aktivitaet_richtung_id
   = '2'
 INNER JOIN kfl_production_dbp_msi_view3.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V06 ON V01.wrg_typ_id = V06.wrg_typ_id;
