create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TS_SCM_TOR_GRUPPE_MAP(
	MANDANT_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	TOR_ID_ZUGEORDNET,
	TOR_GRUPPE,
	HALLENSEITE_ID,
	HALLENSEITE_BEZ
) as 


    SELECT 
         v1.mandant_id
        ,v1.lagernummer_id
        ,v1.wup_id
        ,v1.nb_id
        ,v1.tor_id_zugeordnet
        ,COALESCE(v2.tor_gruppe,'-1')
        ,COALESCE(NULLIF(v2.hallenseite_bez,''),'-1')
        ,COALESCE(v2.hallenseite_bez,'-1')

FROM (SELECT DISTINCT 
lagernummer_id,
mandant_id,
wup_id,
nb_id,
tor_id_zugeordnet
FROM dbp_view.v_wup_lagernummer_bsflaeche_per t01 WHERE EXISTS (SELECT 1 FROM  DBP_DATA.L_VZ_SAP_SYSTEM_ZU SVZ
JOIN DBP_DATA.L_SYSTEM S ON SVZ.MANDANT_ID=S.MANDANT_ID AND SVZ.SYSTEM_ID=S.SYSTEM_ID
WHERE S.SYSTEM_GRUPPE = 'SAP LVS' AND SVZ.MANDANT_ID=T01.MANDANT_ID AND SVZ.WUP_ID = T01.WUP_ID AND SVZ.SYSTEM_ID=T01.SYSTEM_ID))v1

LEFT JOIN
dbp_view.v_ts_scm_tor_gruppe_map v2

ON
v1.lagernummer_id=v2.lagernummer_id
AND v1.mandant_id=v2.mandant_id
AND v1.wup_id=v2.wup_id
AND v1.nb_id=v2.nb_id
AND v1.tor_id_zugeordnet=v2.tor_id_zugeordnet;