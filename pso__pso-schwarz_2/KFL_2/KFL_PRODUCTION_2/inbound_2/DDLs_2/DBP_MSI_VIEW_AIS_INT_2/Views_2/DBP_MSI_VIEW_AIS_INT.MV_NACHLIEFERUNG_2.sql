CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_NACHLIEFERUNG_2
AS
SELECT
v1.nachlieferung_request_id
,v1.mandant_id
,v1.gp_exp_name
,v1.dat_start
,v1.anzahl_dateien
,v1.ldap_user AS user_id
,v1.wup_id
,0 AS nb_id
,v1.art_id
,v1.datzeit_insert
,v1.datzeit_update
,v1.active_fg
,v1.gp_id
,v1.periodizitaet
,TO_CHAR(v2.kl_art_id, 'FM00000000') kl_art_id_lang
,v3.art_bez
,v3.art_bez_de
,v3.art_bez_cz
,v3.art_bez_sk
,v3.art_bez_hr
,v3.art_bez_pl
,v3.art_bez_ro
,v3.art_bez_bg
FROM dbp_msi_v_view.v_ts_nachlieferung_2 v1
// joined art_2 table in order NULL values 
// not to be filtered in the frontend
LEFT JOIN dbp_view.v_art_2 v2
ON v1.art_id = v2.art_id
AND v1.mandant_id = v2.mandant_id
//left join mv_art_spr_zu_2
LEFT JOIN (SELECT
   v01.mandant_id, v01.art_id, v02.kl_art_id, COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez                                                             
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez_de                                                     
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.art_bez END), art_bez_de) AS art_bez_cz  
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.art_bez END), art_bez_de) AS art_bez_sk 
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.art_bez END), art_bez_de) AS art_bez_hr    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.art_bez END), art_bez_de) AS art_bez_pl    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.art_bez END), art_bez_de) AS art_bez_ro   
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.art_bez END), art_bez_de) AS art_bez_bg  
   FROM dbp_view.v_art_spr_zu_2 v01
   JOIN dbp_view.v_art_2 v02
   ON (v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id)
   GROUP BY 1,2,3) v3 
ON v1.art_id = v3.art_id
AND v1.mandant_id = v3.mandant_id;