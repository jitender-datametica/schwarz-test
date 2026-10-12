CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_MONAT_SPR_ZU 
as 
SELECT
     v01.mo_id,
   CAST(v01.mo_bez AS VARCHAR(40)) AS mo_bez,
   v02.kjmo,
   v02.kj,
   CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) AS mo_bez_lang,
v01.spr_id
  FROM dbp_view.v_monat_spr_zu v01

   JOIN dbp_view.v_monat v02
   ON v01.mo_id = v02.mo_kj;