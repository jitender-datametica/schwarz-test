CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_SM_VW_ZU
-- MR 02.03.2012 erstellt Aktuell View
--sschuecke / 12.02.2014 Einschränkung auf vw_id = 10 wegen Verdopplungen - EK-3586233
--lsvi0303 INC4697119
(
 art_id
,vw_id
,sm_id
,ksm_id
,mandant_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
 --03.09.2024 SPEC0268361, Einschänkung auf maximales dat_von um keine doppelten Zeilen zu erhalten
 --11.12,2024 INC9847779, sm_id für alle Mandaten aus View v_sm ziehen
  SELECT
   v01.art_id,
   v01.vw_id,
   CAST(TRIM(v02.sap_sm_id) AS VARCHAR(2)) AS sm_id,
   v01.ksm_id,
   v01.mandant_id
   FROM dbp_view.v_art_sm_vw_zu_per v01
   JOIN dbp_view.v_sm v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.sm_id=v02.sm_id					 					  
   JOIN (
   SELECT
   v03.art_id,
   v03.vw_id,
   v03.mandant_id,
   MAX(v03.dat_von) AS dat_von
   FROM dbp_view.v_art_sm_vw_zu_per v03
   --WHERE v03.dat_bis >= CURRENT_DATE
   WHERE v03.mandant_id <> 1
   AND v03.vw_id = 10
   GROUP BY 1,2,3
   ) 
   t1
   WHERE t1.art_id=v01.art_id
   AND t1.vw_id=v01.vw_id
   AND t1.mandant_id=v01.mandant_id
   AND t1.dat_von=v01.dat_von;