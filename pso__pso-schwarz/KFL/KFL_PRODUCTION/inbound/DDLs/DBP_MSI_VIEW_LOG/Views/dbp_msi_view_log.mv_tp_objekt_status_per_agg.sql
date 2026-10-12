CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TP_OBJEKT_STATUS_PER_AGG(
	TP_OBJEKT_ID,
	MANDANT_ID,
	TP_OBJEKT_STATUS_ID_AGG,
	TP_OBJEKT_STATUS_KBEZ_AGG,
	TP_OBJEKT_STATUS_KBEZ_DE_AGG,
	TP_OBJEKT_STATUS_KBEZ_CZ_AGG,
	TP_OBJEKT_STATUS_KBEZ_SK_AGG,
	TP_OBJEKT_STATUS_KBEZ_HR_AGG,
	TP_OBJEKT_STATUS_KBEZ_PL_AGG,
	TP_OBJEKT_STATUS_KBEZ_RO_AGG,
	TP_OBJEKT_STATUS_KBEZ_BG_AGG
) AS
--AP0133256_SPEC0166769, dknop, initial
SELECT
 tp_objekt_id
,mandant_id
,listagg(tp_objekt_status_id,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez ASC) AS tp_objekt_status_id_agg
,listagg(tp_objekt_status_kbez,' ' ) WITHIN GROUP (ORDER BY tp_objekt_status_kbez ASC) AS tp_objekt_status_kbez_agg 
,listagg(tp_objekt_status_kbez_de,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_de ASC) AS tp_objekt_status_kbez_de_agg    
,listagg(tp_objekt_status_kbez_cz,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_cz ASC) AS tp_objekt_status_kbez_cz_agg
,listagg(tp_objekt_status_kbez_sk,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_sk ASC) AS tp_objekt_status_kbez_sk_agg 
,listagg(tp_objekt_status_kbez_hr,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_hr ASC) AS tp_objekt_status_kbez_hr_agg
,listagg(tp_objekt_status_kbez_pl,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_pl ASC) AS tp_objekt_status_kbez_pl_agg 
,listagg(tp_objekt_status_kbez_ro,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_ro ASC) AS tp_objekt_status_kbez_ro_agg
,listagg(tp_objekt_status_kbez_bg,' ') WITHIN GROUP (ORDER BY tp_objekt_status_kbez_bg ASC) AS tp_objekt_status_kbez_bg_agg
   FROM (
SELECT
tp_obj_s.mandant_id
,tp_obj_s.tp_objekt_id
,tp_obj_s.tp_objekt_status_id
,tp_objekt_status_kbez 
,tp_objekt_status_kbez_de
,tp_objekt_status_kbez_cz
,tp_objekt_status_kbez_sk
,tp_objekt_status_kbez_hr
,tp_objekt_status_kbez_pl
,tp_objekt_status_kbez_ro
,tp_objekt_status_kbez_bg
FROM dbp_view.v_tp_objekt_status_per tp_obj_s
JOIN (
  SELECT 
 tp_obj_s_spr.mandant_id
,tp_obj_s_spr.tp_objekt_status_id
,MAX(CASE WHEN tp_obj_s_spr.spr_id =  22 THEN tp_obj_s_spr.tp_objekt_status_kbez END) AS tp_objekt_status_kbez                 -- standard == DE
,MAX(CASE WHEN tp_obj_s_spr.spr_id =  22 THEN tp_obj_s_spr.tp_objekt_status_kbez END) AS tp_objekt_status_kbez_de                       -- DE
,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id = 124 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_cz    -- CZ
,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id = 108 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_sk   -- SK
,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  65 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_hr    -- HR
,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  90 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_pl    -- PL
,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  95 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_ro    -- RO
,COALESCE(MAX(CASE WHEN tp_obj_s_spr.spr_id =  18 THEN tp_obj_s_spr.tp_objekt_status_kbez END), tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_bg    -- BG
     FROM dbp_view.v_tp_objekt_status_spr_zu tp_obj_s_spr
GROUP BY 
   tp_obj_s_spr.mandant_id
,tp_obj_s_spr.tp_objekt_status_id
)tp_obj_s_spr
ON tp_obj_s.mandant_id=tp_obj_s_spr.mandant_id
AND tp_obj_s.tp_objekt_status_id=tp_obj_s_spr.tp_objekt_status_id
WHERE tp_objekt_status_fg = 0
AND dat_bis   = '9999-12-31'
        )
GROUP BY tp_objekt_id,
mandant_id
;