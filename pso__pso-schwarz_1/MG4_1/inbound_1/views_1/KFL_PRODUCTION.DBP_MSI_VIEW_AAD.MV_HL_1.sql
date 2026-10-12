create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_HL_1(
	MANDANT_ID,
	HL_ID,
	HL_NAME,
	HL_NAME_CZ,
	HL_NAME_SK,
	HL_NAME_HR,
	HL_NAME_PL,
	HL_NAME_RO,
	HL_NAME_BG
) as
--15.06.2023 snik: SPEC0200542 Lookup HL_1, analog KMR
SELECT
  mandant_id
, ma_id AS hl_id
, MAX(CASE WHEN spr_id = 22 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END)						AS hl_name
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)	AS hl_name_cz
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)	AS hl_name_sk
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)	AS hl_name_hr
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)	AS hl_name_pl
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)	AS hl_name_ro
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)	AS hl_name_bg
FROM dbp_view.v_ma_spr_zu_1 msz
WHERE (mandant_id, ma_id) IN
    (
    SELECT mandant_id, hl_id
    FROM dbp_view.v_wup_1
    UNION ALL
    SELECT mandant_id, (1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER
    FROM dbp_view.v_vs_1
    )
GROUP BY
mandant_id
,ma_id;