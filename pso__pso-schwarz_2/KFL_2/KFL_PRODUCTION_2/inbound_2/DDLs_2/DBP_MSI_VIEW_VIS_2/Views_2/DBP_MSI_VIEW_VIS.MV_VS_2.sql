CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VS_2(
  MANDANT_ID
 ,VS_ID
 ,VS_SORT
 ,VSVT_BEZ
 ,VSVT_BEZ_CZ
 ,VSVT_BEZ_SK
 ,VSVT_BEZ_HR
 ,VSVT_BEZ_PL
 ,VSVT_BEZ_RO
 ,VSVT_BEZ_BG
 ,GL_VERTRIEB_ID
 ,MA_NAME
 ,MA_VORNAME
 ,MA_ANREDE
 ,VK_ID
 ,VS_BEZ
 ,VSVT_BEZ_OLD
) AS  
/* LOOKUP Region_2 (Vertrieb) 
 2011KW28 Review + Filter 
 20121127 Umstellung auf GL_Vertrieb, Anreicherung 
 2020-09-25 ssch0611 : synchronized with mandant_2 
 2021-02-09 ssch0611 : translations 
 2021-03-05 ssch0611 : Review after MA-Update (reference wup_2/wup_denorm_2) 
 2021-03-08 ssch0611 : review Translations 
 2023-01-16 ssch0611 : added 2 Regionen/GL in RO -- AP0157908 
 2024-08-01 muellerpatri : CASE-WHEN für Polen angepasst
*/ 
SELECT 
 mdt.mandant_id 
,vsr.vs_id 
/* official sorting VT */
,CASE 
   WHEN mdt.mandant_id = 1 AND vsr.vs_id = 7 THEN 11 
   WHEN mdt.mandant_id = 1 AND vsr.vs_id = 2 THEN 12 
   WHEN mdt.mandant_id = 1 AND vsr.vs_id = 3 THEN 13 
   WHEN mdt.mandant_id = 1 AND vsr.vs_id = 1 THEN 14 
   WHEN mdt.mandant_id = 1 AND vsr.vs_id = 8 THEN 15 
   WHEN mdt.mandant_id = 1 AND vsr.vs_id = 6 THEN 16 
   WHEN vsr.vs_id = 0 THEN (mdt.mandant_sort_id * 10) + 9 
   ELSE (mdt.mandant_sort_id * 10) + vsr.vs_id 
 END AS vs_sort 
/* translations */
,CASE 
  WHEN mdt.mandant_id = 1 AND vsr.vs_id = 0 THEN 'Deutschland (NN)' 
  WHEN mdt.mandant_id = 3 AND vsr.vs_id = 0 THEN 'Polen'   
  WHEN mdt.mandant_id = 7 AND vsr.vs_id = 0 THEN 'Rumänien (NN)' 
  WHEN mdt.mandant_id = 7 AND vsr.vs_id = 1 THEN 'Rumänien West' 
  WHEN mdt.mandant_id = 7 AND vsr.vs_id = 2 THEN 'Rumänien Ost' 
 ELSE vsr.vsvt_bez END AS vsvt_bez 
,CASE 
  WHEN mdt.mandant_id = 2 AND vsr.vs_id = 0 THEN 'Česko' 
  WHEN mdt.mandant_id = 5 AND vsr.vs_id = 0 THEN 'Slovensko' 
 ELSE vsr.vsvt_bez END AS vsvt_bez_cz 
,CASE 
  WHEN mdt.mandant_id = 2 AND vsr.vs_id = 0 THEN 'Česko' 
  WHEN mdt.mandant_id = 5 AND vsr.vs_id = 0 THEN 'Slovensko' 
 ELSE vsr.vsvt_bez END AS vsvt_bez_sk 
,CASE 
  WHEN mdt.mandant_id = 6 AND vsr.vs_id = 0 THEN 'Hrvatska' 
 ELSE vsr.vsvt_bez END AS vsvt_bez_hr 
,CASE 
  WHEN mdt.mandant_id = 3 AND vsr.vs_id = 0 THEN 'Polska' 
 ELSE vsr.vsvt_bez END AS vsvt_bez_pl 
,CASE 
  WHEN mdt.mandant_id = 4 AND vsr.vs_id = 0 THEN 'Moldova' 
  WHEN mdt.mandant_id = 7 AND vsr.vs_id = 0 THEN 'România (NN)' 
  WHEN mdt.mandant_id = 7 AND vsr.vs_id = 1 THEN 'România Vest' 
  WHEN mdt.mandant_id = 7 AND vsr.vs_id = 2 THEN 'România Est' 
 ELSE vsr.vsvt_bez END AS vsvt_bez_ro 
,CASE 
  WHEN mdt.mandant_id = 8 AND vsr.vs_id = 0 THEN 'България' 
 ELSE vsr.vsvt_bez END AS vsvt_bez_bg 
,COALESCE(wdw.gl_vertrieb_id, -1) AS gl_vertrieb_id 
,COALESCE(msz.ma_name, '--')      AS ma_name 
,COALESCE(msz.ma_vorname, '--')   AS ma_vorname 
,msz.ma_anrede 
,vsr.vk_id 
,vsr.vs_bez 
,vsr.vsvt_bez AS vsvt_bez_old 
FROM dbp_view.v_mandant_2 mdt 
JOIN dbp_view.v_vs_2 vsr 
ON mdt.mandant_id = vsr.mandant_id 
JOIN (
 SELECT DISTINCT 
  ww.mandant_id 
 ,ww.vs_id 
 ,MAX(wd.gl_vertrieb_id) OVER (PARTITION BY ww.mandant_id, ww.vs_id) AS gl_vertrieb_id 
 FROM dbp_view.v_wup_2 ww 
 LEFT JOIN dbp_msi_v_view.v_wup_denorm_2 wd 
 ON ww.mandant_id = wd.mandant_id 
 AND ww.wup_id = wd.wup_id 
 WHERE ww.nb_id IN(-1, 0) 
 AND ww.dat_eroeffnung < TO_DATE('2090-12-30', 'YYYY-MM_2-DD') 
 AND ww.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM_2-DD') 
) wdw 
ON vsr.mandant_id = wdw.mandant_id 
AND vsr.vs_id = wdw.vs_id 
LEFT JOIN (
 SELECT 
  mandant_id 
 ,ma_id 
 ,ma_name 
 ,ma_vorname 
 ,ma_anrede 
 FROM dbp_view.v_ma_spr_zu_2 
 WHERE spr_id = 22 
) msz 
ON wdw.mandant_id = msz.mandant_id 
AND wdw.gl_vertrieb_id = msz.ma_id;