create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WERBEGRUPPE_FLEISCH_1(
	WERBEGRUPPE_FLEISCH,
	WERBEGRUPPE_FLEISCH_BEZ,
	WERBEGRUPPE_FLEISCH_BEZ_DE,
	WERBEGRUPPE_FLEISCH_BEZ_CZ,
	WERBEGRUPPE_FLEISCH_BEZ_SK,
	WERBEGRUPPE_FLEISCH_BEZ_HR,
	WERBEGRUPPE_FLEISCH_BEZ_PL,
	WERBEGRUPPE_FLEISCH_BEZ_RO,
	WERBEGRUPPE_FLEISCH_BEZ_BG
) as

SELECT
v01.marktmerkmal_wert as werbegruppe_fleisch,
Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez          END) AS werbegruppe_fleisch_bez       
,
Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez  END) AS werbegruppe_fleisch_bez_de         
,
Coalesce(Max(CASE WHEN spr_id = 124 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_cz    
,
Coalesce(Max(CASE WHEN spr_id = 108 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_sk    
,
Coalesce(Max(CASE WHEN spr_id =  65 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_hr    
,
Coalesce(Max(CASE WHEN spr_id =  90 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_pl    
,
Coalesce(Max(CASE WHEN spr_id =  95 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_ro    
,
Coalesce(Max(CASE WHEN spr_id =  18 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_bg    

FROM dbp_view.v_marktmerkmal_wert_spr_zu_1 v01
where v01.marktmerkmal_id='0051'
GROUP BY  v01.marktmerkmal_wert;