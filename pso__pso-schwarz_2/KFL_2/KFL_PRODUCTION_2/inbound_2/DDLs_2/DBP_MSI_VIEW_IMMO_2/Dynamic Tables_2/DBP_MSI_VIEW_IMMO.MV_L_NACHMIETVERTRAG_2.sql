CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_NACHMIETVERTRAG_2(
	MANDANT_ID,
	MO_INTRENO,
	NACH_MV_INTRENO,
	NACH_MV_MIETVERTRAG_NR,
	MO_STATUS_ID,
	DAT_STATUS_VON,
	DAT_STATUS_BIS,
	DAT_MIET_BEGINN,
	DAT_MIET_ENDE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
SELECT
    b.mandant_id,
    b.mo_intreno,
    b.mv_intreno AS nach_mv_intreno,
    a.mietvertrag_nr AS nach_mv_mietvertrag_nr,
    b.mo_status_id,
    b.dat_status_von,
    b.dat_status_bis,
    a.dat_miet_beginn,
    a.dat_miet_ende
FROM
    dbp_view.v_immo_mietvertrag_per_2 a
    JOIN dbp_view.v_immo_mo_status_per_2 b ON a.mandant_id = b.mandant_id
    AND a.mv_intreno = b.mv_intreno
WHERE
    a.dat_miet_beginn > CURRENT_DATE
    AND CURRENT_DATE BETWEEN b.dat_status_von
    AND b.dat_status_bis
UNION
ALL
SELECT
    mandant_id,
    '' AS mo_intreno,
    '' AS nach_mv_intreno,
    '' AS nach_mv_mietvertrag_nr,
    -1 AS mo_status_id,
    CAST ('1900-01-01' AS VARCHAR) AS dat_status_von,
    CAST ('9999-12-31' AS VARCHAR) AS dat_status_bis,
    CAST ('1900-01-01' AS VARCHAR) AS dat_miet_beginn,
    CAST ('9999-12-31' AS VARCHAR) AS dat_miet_ende
FROM
    dbp_view.v_mandant_2;