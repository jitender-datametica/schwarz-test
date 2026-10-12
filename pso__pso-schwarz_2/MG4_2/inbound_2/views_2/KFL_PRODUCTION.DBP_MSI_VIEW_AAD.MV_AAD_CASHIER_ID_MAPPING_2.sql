create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_AAD_CASHIER_ID_MAPPING_2(
	HASHED_CASHIER_ID,
	MANDANT_ID,
	WUP_ID,
	KASSIERER_NR,
	HASH_GENERATION_DT,
	HASHED_CASHIER_BEZ
) as







SELECT 
      v01.hashed_cashier_id
    , v01.mandant_id
    , v02.aktuell_wup_id AS wup_id
    , v01.kassierer_nr
    , v01.hash_generation_dt
    , LEFT(v01.hashed_cashier_id, 30) AS hashed_cashier_bez
FROM DBP_VIEW.V_AAD_CASHIER_ID_MAPPING_2 v01

INNER JOIN dbp_view.v_wup_2 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;