CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ART_SM_VW_ZU(
	ART_ID,
	VW_ID,
	SM_ID,
   KSM_ID,
	MANDANT_ID
) AS
   --03.09.2024 SPEC0268361, Neuanlage
   --18.10.2024 SPEC0276662, Aufnahme KSM_ID
   --11.12,2024 INC9847779, sm_id für alle Mandaten aus View v_sm ziehen
   SELECT
   v01.art_id,
   v01.vw_id,
   CAST(TRIM(v02.sap_sm_id) AS VARCHAR(2)) AS sm_id,
   CAST(TRIM(CASE WHEN v01.mandant_id = 1 THEN v02.sap_sm_id ELSE TO_VARCHAR(v01.ksm_id) END) AS VARCHAR(2)) AS k_sm_id,
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
   GROUP BY 1,2,3) 
   t1
   WHERE t1.art_id=v01.art_id
   AND t1.vw_id=v01.vw_id
   AND t1.mandant_id=v01.mandant_id
   AND t1.dat_von=v01.dat_von
   AND v02.spr_id=22;