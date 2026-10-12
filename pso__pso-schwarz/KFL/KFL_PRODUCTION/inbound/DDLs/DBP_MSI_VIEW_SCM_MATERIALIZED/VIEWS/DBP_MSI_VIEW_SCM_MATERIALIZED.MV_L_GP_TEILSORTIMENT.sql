create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_GP_TEILSORTIMENT(
	MANDANT_ID,
	GP_ID,
	GP_TEILSORTIMENT_ID,
	EINKAUFSORGANISATION_ID,
	ZAHLUNGSZIEL_ID,
	ZEK_ID
) as
SELECT
v01.mandant_id
,v01.gp_id
,v01.gp_teilsortiment_id
,v01.einkaufsorganisation_id
,v01.zahlungsziel_id
,v01.zek_id
FROM dbp_view.v_l_gp_teilsortiment v01
--- dummy records for empty LTS
UNION ALL
SELECT
v02.mandant_id
,v02.gp_id
,'' AS gp_teilsortiment_id
,v02.einkaufsorganisation_id
,v02.zahlungsziel_id
,v02.zek_id
FROM dbp_view.v_gp v02
WHERE (v02.mandant_id,v02.gp_id,'') NOT IN 
    (SELECT DISTINCT mandant_id,gp_id,gp_teilsortiment_id  FROM dbp_view.v_l_gp_teilsortiment);