CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_KAUFLAND_STORE_CUSTOMER_REVIEW(
	MANDANT_ID,
	SYSTEM_NAME,
	NB_ID,
	WUP_ID,
	DAT,
	KFL_REVIEW_RATING,
	KFL_REVIEW_NMBR,
    KFL_REVIEW_ID,
	KFL_REVIEW_TMSP
) AS 
	-- KMR Google : Kaufland Bewertungen
	-- 2024-02-27 : Review 
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
    -- 2025-05-06 muellerpatri : Änderung von SID auf ID

SELECT
	RSR.MANDANT_ID
	, RSR.EXT_SYSTEM_NAME                                                       AS SYSTEM_NAME
	, RSR.NB_ID
	, wup.aktuell_wup_id 														AS wup_id
	, TO_DATE(RSR.REVIEW_TMSP) 													AS DAT
	, RSR.REVIEW_RATING        													AS KFL_REVIEW_RATING
	, 1::INTEGER               													AS KFL_REVIEW_NMBR
	, RSR.EXT_CUSTOMER_REVIEW_ID                                               	AS KFL_REVIEW_ID
	, RSR.REVIEW_TMSP          													AS KFL_REVIEW_TMSP
FROM DBP_VIEW.V_RETAIL_STORE_CUSTOMER_REVIEW RSR
 
INNER JOIN DBP_VIEW.V_RETAIL_COMPANY RCO 
ON RCO.EXT_RETAIL_COMPANY_ID = RSR.EXT_RETAIL_COMPANY_ID AND RCO.EXT_SYSTEM_NAME = RSR.EXT_SYSTEM_NAME 

INNER JOIN dbp_view.v_wup wup
ON RSR.mandant_id = wup.mandant_id AND RSR.wup_id = wup.wup_id

WHERE COMPETITOR_FG <> 1
;