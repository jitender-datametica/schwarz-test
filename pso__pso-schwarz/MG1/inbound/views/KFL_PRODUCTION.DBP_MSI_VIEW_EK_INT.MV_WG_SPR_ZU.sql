create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WG_SPR_ZU(
	MANDANT_ID,
	ARTHIERTYP_ID,
	WG_ID,
	WG_GESPERRT,
	WG_BEZ,
	WG_BEZ_DE,
	WG_BEZ_CZ,
	WG_BEZ_SK,
	WG_BEZ_HR,
	WG_BEZ_PL,
	WG_BEZ_RO,
	WG_BEZ_BG
) as
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, max(coalesce(decode(position(wg_bez,upper(CASE WHEN v01.mandant_id = 1 then 'Gesperrt'
   WHEN v01.mandant_id = 2 then 'BLOKOVÁNO'
   WHEN v01.mandant_id = 3 then 'zablokowane'
   WHEN v01.mandant_id = 5 then 'Blokované'
   WHEN v01.mandant_id = 6 then 'ZATVORENO'
   WHEN v01.mandant_id = 7 then 'ÎNCHIS'
   WHEN v01.mandant_id = 8 then 'Блокирана' End)),1,1)  , 0)) as wg_gesperrt, COALESCE(MAX(CASE WHEN spr_id =  22 THEN wg_bez END),'N/A') AS wg_bez                                                             
   , COALESCE(MAX(CASE WHEN spr_id =  22 THEN wg_bez END),'N/A') AS wg_bez_de                                                     
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), wg_bez_de) AS wg_bez_cz  
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), wg_bez_de) AS wg_bez_sk 
   , COALESCE(MAX(CASE WHEN spr_id =  65  THEN wg_bez END), wg_bez_de) AS wg_bez_hr    
   , COALESCE(MAX(CASE WHEN spr_id =  90  THEN wg_bez END), wg_bez_de) AS wg_bez_pl    
   , COALESCE(MAX(CASE WHEN spr_id =  95  THEN wg_bez END), wg_bez_de) AS wg_bez_ro   
   , COALESCE(MAX(CASE WHEN spr_id =  18  THEN wg_bez END), wg_bez_de) AS wg_bez_bg  

   FROM dbp_view.v_wg_per v01
   INNER JOIN dbp_view.v_wg_spr_zu  v02
   ON  v01.wg_id = v02.wg_id

   WHERE v01.arthiertyp_id = 2 and v02.arthiertyp_id = 2

   GROUP BY 1, 2, 3;