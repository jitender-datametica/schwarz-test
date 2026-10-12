CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_TAB_NIO_ARTIKEL(
	CLIENT_ID COMMENT 'Client ID',
	WH_ID COMMENT 'Warehouse ID',
	HU_IDENT COMMENT 'NIO History Handling Unit Identification',
	CRTD_ON_DT COMMENT 'NIO History Created on',
	ARTIKEL_ID COMMENT 'Product Item ID',
	ARTIKEL_DESC COMMENT 'Product Item Description'
) AS
WITH rmv_dpl AS (
    SELECT
        client_id,
        wh_id,
        huident AS hu_ident,
        TO_DATE(UTC_TIMESTAMP) AS crtd_on_dt,
        matnr AS artikel_id,
        maktx AS artikel_desc,
        dwh_load_id,
        dwh_created,
        dwh_updated,
        ROW_NUMBER() OVER (
            PARTITION BY client_id, wh_id, huident, TO_DATE(UTC_TIMESTAMP), matnr
            ORDER BY TO_DATE(UTC_TIMESTAMP)
        ) AS rn
    FROM DATA.t_sapewm_niohistory
)
SELECT
    client_id,
    wh_id,
    hu_ident,
    crtd_on_dt,
    artikel_id,
    artikel_desc
FROM rmv_dpl
WHERE rn = 1
;