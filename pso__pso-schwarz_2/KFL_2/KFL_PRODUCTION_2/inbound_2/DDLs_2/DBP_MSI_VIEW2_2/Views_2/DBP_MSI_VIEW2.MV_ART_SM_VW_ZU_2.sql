CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_SM_VW_ZU_2(
	ART_ID,
	VW_ID,
	SM_ID,
	MANDANT_ID
) AS
  --03.09.2024 SPEC0268361, Neuanlage
   SELECT
   v01.art_id,
   v01.vw_id,
   CAST(TRIM(v02.sap_sm_id) AS VARCHAR(2)) AS sm_id,
   v01.mandant_id
   FROM dbp_view.v_art_sm_vw_zu_per_2 v01
   JOIN dbp_view.v_sm_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.sm_id=v02.sm_id
   JOIN (
   SELECT
   v03.art_id,
   v03.vw_id,
   v03.mandant_id,
   MAX(v03.dat_von) AS dat_von
   FROM dbp_view.v_art_sm_vw_zu_per_2 v03
   --WHERE v03.dat_bis >= CURRENT_DATE
   WHERE v03.mandant_id = 1
   GROUP BY 1,2,3) 
   t1_2
   WHERE t1.art_id=v01.art_id
   AND t1.vw_id=v01.vw_id
   AND t1.mandant_id=v01.mandant_id
   AND t1.dat_von=v01.dat_von;