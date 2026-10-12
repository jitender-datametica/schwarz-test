create or replace view UGS_ARIS_PRODUCTION.FE_MSTR_ARIS.V_FACT_PROCESS_TO_STORE_AREA_COUNT_2(
	DWH_TENANT_CD,
	PROCESS_SID,
	FT,
	NF,
	BS,
	BT,
	FL,
	PF,
	VT,
	IM,
	FS,
	KA,
	LA,
	LG,
	FF,
	IF
) as (

SELECT DWH_TENANT_CD,
PROCESS_SID,
sum(Case when STORE_AREA_CD = 'FT' then 1 else 0 end) FT,
sum(Case when STORE_AREA_CD = 'NF' then 1 else 0 end) NF,
sum(Case when STORE_AREA_CD = 'BS' then 1 else 0 end) BS,
sum(Case when STORE_AREA_CD = 'BT' then 1 else 0 end) BT,
sum(Case when STORE_AREA_CD = 'FL' then 1 else 0 end) FL,
sum(Case when STORE_AREA_CD = 'PF' then 1 else 0 end) PF,
sum(Case when STORE_AREA_CD = 'VT' then 1 else 0 end) VT,
sum(Case when STORE_AREA_CD = 'IM' then 1 else 0 end) IM,
sum(Case when STORE_AREA_CD = 'FS' then 1 else 0 end) FS,
sum(Case when STORE_AREA_CD = 'KA' then 1 else 0 end) KA,
sum(Case when STORE_AREA_CD = 'LA' then 1 else 0 end) LA,
sum(Case when STORE_AREA_CD = 'LG' then 1 else 0 end) LG,
sum(Case when STORE_AREA_CD = 'FF' then 1 else 0 end) FF,
sum(Case when STORE_AREA_CD = 'IF' then 1 else 0 end) IF

FROM CORE.T_FACT_PROCESS_TO_STORE_AREA_2
WHERE DWH_VALID_FG=TRUE
GROUP BY 1,2);