CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_HFM_MARKE_1(
	MANDANT_ID,
	ART_ID,
	HFM_C2_MARKE
) AS
SELECT
a11.mandant_id,
a11.art_id, 
CASE WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id ='' AND aldi_id = 1 AND yellowprint_fg = 1 AND a11.MANDANT_ID !=1 THEN 'MA_FM_PE'
WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id =''  AND a11.MANDANT_ID !=1 THEN 'MA_FM_MA_SO'
WHEN a13.abt_id = 8 AND a11.eigenmarke_id = 'H' AND a11.MANDANT_ID !=1 THEN 'MA_EM_HM'
WHEN a13.abt_id = 8 AND a11.eigenmarke_id IS NOT NULL AND a11.MANDANT_ID !=1 THEN 'MA_EM_OK' 
WHEN a11.eigenmarke_id = 'H' AND a11.MANDANT_ID =1 THEN 'MA_EM_HM'
WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id ='' AND a11.aldi_id != 0 AND (a11.discountart_id ='AM' OR a11.discountart_id ='DC') AND a11.MANDANT_ID =1 THEN 'MA_FM_MA_DC'
WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id ='' AND a11.aldi_id != 0 AND a11.MANDANT_ID =1 THEN 'MA_FM_PE'
WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id ='' AND a11.MANDANT_ID =1 THEN 'MA_FM_MA_SO'
WHEN a13.abt_id = 8 AND a11.MANDANT_ID =1 THEN 'MA_EM_OK'
ELSE IFNULL(a17.hfm_markengruppe_kz,'Keine Eigenmarkenzuordnung') END AS HFM_C2_MARKE
FROM (
SELECT
v01.mandant_id,
v01.art_id,
v01.eigenmarke_id,
v01.aldi_id,
v01.yellowprint_fg,
v01.discount_id,
v01.discountart_id
FROM dbp_view.v_art_1 v01
JOIN dbp_view.v_mandant_1 v02
ON v01.mandant_id = v02.mandant_id
) a11
JOIN (
   SELECT
   mandant_id,
   v01.art_id,
   v01.wg_id,
   v01.wug_id,
   v01.arthiertyp_id
   FROM dbp_view.v_art_wg_zu_per_1 v01

   WHERE v01.arthiertyp_id = 2
   AND v01.dat_bis = '9999-12-31'
)a12 
ON (a11.art_id =a12.art_id AND a11.mandant_id =a12.mandant_id)
JOIN (
   SELECT
   v01.mandant_id,
   v01.wg_id,
   v01.arthiertyp_id,
   v01.abt_id,
   CASE
   WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END AS wg_id_lang,
   v01.owg_id
   FROM dbp_view.v_wg_per_1 v01
   WHERE v01.dat_bis = '9999-12-31' 
)a13
ON (a12.mandant_id = a13.mandant_id AND a12.wg_id = a13.wg_id)
JOIN (
 SELECT
   v01.owg_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id,
   v01.hwg_id
   FROM dbp_view.v_owg_per_1 v01
   WHERE v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31'
)a14
ON (a13.mandant_id=a14.mandant_id AND a13.owg_id =a14.owg_id)   
JOIN (
SELECT
   v01.mandant_id, v01.art_id, v02.kl_art_id, COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez       
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez_de                                            
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.art_bez END), art_bez_de) AS art_bez_cz  
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.art_bez END), art_bez_de) AS art_bez_sk 
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.art_bez END), art_bez_de) AS art_bez_hr    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.art_bez END), art_bez_de) AS art_bez_pl    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.art_bez END), art_bez_de) AS art_bez_ro   
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.art_bez END), art_bez_de) AS art_bez_bg  

   FROM dbp_view.v_art_spr_zu_1 v01

   JOIN dbp_view.v_art_1 v02
   ON (v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id)
   GROUP BY 1,2,3
) a15

ON (a11.art_id=a15.art_id AND a11.mandant_id=a15.mandant_id) 

LEFT JOIN dbp_view.V_L_EIGENMARKE_HFM_KZ_1 a17
ON (a11.eigenmarke_id = a17.eigenmarke_id AND a11.mandant_id=a17.mandant_id)
AND 
CASE 
WHEN a11.art_id < 10000000 THEN '00' || CAST(CAST((a11.art_id/100) AS NUMBER(38,0)) AS VARCHAR (100))
WHEN a11.art_id < 100000000 THEN '0' || CAST(CAST((a11.art_id/100) AS NUMBER (38,0)) AS VARCHAR (100))
ELSE CAST(CAST((a11.art_id/100) AS NUMBER (38)) AS VARCHAR(100)) END = CASE WHEN a15.art_id < 10000000 THEN '00' || 
CAST(CAST((A15.art_id/100) AS NUMBER(38,0)) AS VARCHAR(100)) WHEN a15.art_id < 100000000 THEN '0' || CAST(CAST((a15.art_id/100) AS NUMBER (38,0)) AS VARCHAR(100))
ELSE CAST(CAST((a15.art_id/100) AS NUMBER (38)) AS VARCHAR(100)) END
;