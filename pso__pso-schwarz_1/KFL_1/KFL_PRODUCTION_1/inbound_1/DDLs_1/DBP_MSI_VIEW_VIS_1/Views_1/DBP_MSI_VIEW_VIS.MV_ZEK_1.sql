CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEK_1(
    ZEK_ID,
    MANDANT_ID,
    ZEK_NAME,
    ZEK_LANG_BEZ
)
AS
-- 2025-05-02 muellerpatri : initiale Erstellung der View [SPEC0309437]
SELECT
    zek_id
    , mandant_id
    , zek_name
    , CASE WHEN zek_id = '-99' THEN '-099' ||' '||zek_name
    WHEN zek_id = '-2' THEN '-002' ||' '||zek_name
    WHEN zek_id = '0' THEN '000' ||' '||zek_name
    ELSE zek_id ||' '||zek_name
    END AS zek_lang_bez
FROM dbp_view.v_zek_1
WHERE zek_id <> '-1';