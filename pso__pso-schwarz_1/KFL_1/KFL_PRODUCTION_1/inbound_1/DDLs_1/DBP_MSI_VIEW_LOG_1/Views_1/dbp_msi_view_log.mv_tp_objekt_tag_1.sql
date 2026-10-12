CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TP_OBJEKT_TAG_1(
	MANDANT_ID,
	TP_OBJEKT_ID,
	TECHN_PLATZ_ID,
	TP_OBJEKT_TYP,
	BAU_KJ,
	BAU_KJMO,
	BAU_MO,
	BAU_DATE,
	DAT_GEWAEHRLEISTUNG_START,
	DAT_GEWAEHRLEISTUNG_START_BEZ,
	DAT_GEWAEHRLEISTUNG_ENDE,
	DAT_GEWAEHRLEISTUNG_ENDE_BEZ,
	TP_OBJEKT_NR,
	ABZUGSDATUM,
	WERK_ID,
	MESSWERT,
	DAT_MESSUNG,
	TP_OBJEKT_STATUS_ID_AGG,
	TP_OBJEKT_STATUS_KBEZ_AGG,
	TP_OBJEKT_STATUS_KBEZ_DE_AGG,
	TP_OBJEKT_STATUS_KBEZ_CZ_AGG,
	TP_OBJEKT_STATUS_KBEZ_SK_AGG,
	TP_OBJEKT_STATUS_KBEZ_HR_AGG,
	TP_OBJEKT_STATUS_KBEZ_PL_AGG,
	TP_OBJEKT_STATUS_KBEZ_RO_AGG,
	TP_OBJEKT_STATUS_KBEZ_BG_AGG,
	GEWAHRLEISTUNG_FG
) AS
--2023-02-06, AP0153902, SPEC0181369, dknop, initial
--2023-04-14, dknop, adding werk_id
--2023-05-04, dknop, updating logic for tp_objekt_status_id_agg, removing duplicates
--2023-05-10, dknop, correcting join to dbp_view.v_in_werk_1 
SELECT 
 tp_o_per.mandant_id
,tp_o_per.tp_objekt_id
,tp_o_per.techn_platz_id
,tp_o_per.tp_objekt_typ
,NULLIFZERO(tp_o_per.bau_kj) AS BAU_KJ
,tp_o_per.bau_kjmo AS BAU_KJMO
,CASE WHEN LEN(tp_o_per.bau_kjmo)=6 THEN RIGHT(tp_o_per.bau_kjmo,2) ELSE NULL END AS BAU_MO
,CASE WHEN LEN(tp_o_per.bau_kjmo)=6 THEN CASE WHEN RIGHT(tp_o_per.bau_kjmo,2)='00' THEN NULL ELSE TO_DATE(CONCAT(tp_o_per.bau_kjmo,'01'),'YYYYMMDD')END ELSE NULL END AS BAU_DATE
,tp_o_per.dat_gewaehrleistung_start
,CASE WHEN dat_gewaehrleistung_start='1900-01-01'THEN NULL ELSE dat_gewaehrleistung_start END AS dat_gewaehrleistung_start_bez
,tp_o_per.dat_gewaehrleistung_ende
,CASE WHEN dat_gewaehrleistung_ende='1900-01-01'THEN NULL ELSE dat_gewaehrleistung_ende END AS dat_gewaehrleistung_ende_bez
,tp_o_per.tp_objekt_nr
,tag.dat AS abzugsdatum 
,in_w.werk_id
,MAX(in_mess.messwert) AS messwert
,MAX(in_mess.dat_messung) AS dat_messung
,listagg(DISTINCT tp_obj_s.tp_objekt_status_id,' ') WITHIN GROUP (ORDER BY tp_obj_s.tp_objekt_status_id ASC) AS tp_objekt_status_id_agg
,listagg(DISTINCT tp_objekt_status_kbez,' ' ) WITHIN GROUP (ORDER BY tp_objekt_status_kbez ASC) AS tp_objekt_status_kbez_agg 
,listagg(DISTINCT tp_objekt_status_kbez_de,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_de ASC) AS tp_objekt_status_kbez_de_agg    
,listagg(DISTINCT tp_objekt_status_kbez_cz,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_cz ASC) AS tp_objekt_status_kbez_cz_agg
,listagg(DISTINCT tp_objekt_status_kbez_sk,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_sk ASC) AS tp_objekt_status_kbez_sk_agg 
,listagg(DISTINCT tp_objekt_status_kbez_hr,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_hr ASC) AS tp_objekt_status_kbez_hr_agg
,listagg(DISTINCT tp_objekt_status_kbez_pl,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_pl ASC) AS tp_objekt_status_kbez_pl_agg 
,listagg(DISTINCT tp_objekt_status_kbez_ro,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_ro ASC) AS tp_objekt_status_kbez_ro_agg
,listagg(DISTINCT tp_objekt_status_kbez_bg,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_bg ASC) AS tp_objekt_status_kbez_bg_agg
,CASE WHEN tag.dat<=tp_o_per.dat_gewaehrleistung_ende THEN 1 ELSE 0 END gewahrleistung_fg

FROM dbp_view.v_tp_objekt_per_1 tp_o_per

JOIN dbp_view.v_tag_1 tag_1
ON tag.dat BETWEEN tp_o_per.dat_von AND tp_o_per.dat_bis
AND tag.dat<=CURRENT_DATE()

JOIN (
          SELECT
          tp_obj_s.mandant_id
         ,tp_obj_s.tp_objekt_id
         ,tp_obj_s.dat_von
         ,tp_obj_s.dat_bis     
         ,tp_obj_s.tp_objekt_status_id
         ,MAX(CASE WHEN tp_obj_s_spr.spr_id =  22 THEN tp_obj_s_spr.tp_objekt_status_kbez END) AS tp_objekt_status_kbez                 -- standard == DE
         ,MAX(CASE WHEN tp_obj_s_spr.spr_id =  22 THEN tp_obj_s_spr.tp_objekt_status_kbez END) AS tp_objekt_status_kbez_de                       -- DE
         ,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id = 124 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_cz    -- CZ
         ,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id = 108 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_sk   -- SK
         ,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  65 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_hr    -- HR
         ,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  90 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_pl    -- PL
         ,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  95 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_ro    -- RO
         ,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  18 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_bg    -- BG
         FROM dbp_view.v_tp_objekt_status_per_1 tp_obj_s
  JOIN dbp_view.v_tp_objekt_status_spr_zu_1 tp_obj_s_spr
  ON tp_obj_s.mandant_id=tp_obj_s_spr.mandant_id
 AND tp_obj_s.tp_objekt_status_id=tp_obj_s_spr.tp_objekt_status_id
  WHERE tp_objekt_status_fg = 0
  GROUP BY tp_obj_s.mandant_id
         ,tp_obj_s.tp_objekt_id
         ,tp_obj_s.dat_von
         ,tp_obj_s.dat_bis     
         ,tp_obj_s.tp_objekt_status_id
)tp_obj_s
     
   ON tag.dat BETWEEN tp_obj_s.dat_von AND tp_obj_s.dat_bis
   AND tp_o_per.tp_objekt_id = tp_obj_s.tp_objekt_id
   AND tp_o_per.mandant_id = tp_obj_s.mandant_id

LEFT JOIN(
  SELECT 
 in_mess.mandant_id
,in_mess.messbeleg_id
,in_mess.messwert
,in_mess.menge_einh_id_messung
,in_mess.dat_messung 
,in_punkt.tp_objekt_id
FROM  dbp_view.v_in_messbeleg_1 in_mess

    JOIN dbp_view.v_in_messpunkt_1 in_punkt
    ON in_mess.messpunkt_id = in_punkt.messpunkt_id
    AND in_mess.mandant_id = in_punkt.mandant_id
  
    )in_mess
  
ON tp_o_per.mandant_id = in_mess.mandant_id
AND tp_o_per.tp_objekt_id = in_mess.tp_objekt_id
AND in_mess.dat_messung<=tag.dat

JOIN dbp_view.v_techn_platz_per_1 tech_pl
ON tp_o_per.mandant_id=tech_pl.mandant_id
AND tp_o_per.techn_platz_id=tech_pl.techn_platz_id
AND tech_pl.dat_bis='9999-12-31' 

JOIN dbp_view.v_in_werk_1 in_w
ON tech_pl.mandant_id= in_w.mandant_id
AND tech_pl.werk_instandhaltung_plan = in_w.werk_nr
--AND tp_o_per.dat_bis='9999-12-31' 

--where tp_o_per.tp_objekt_id= 10157941 and ABZUGSDATUM='2023-05-03'
 
 GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
 ;