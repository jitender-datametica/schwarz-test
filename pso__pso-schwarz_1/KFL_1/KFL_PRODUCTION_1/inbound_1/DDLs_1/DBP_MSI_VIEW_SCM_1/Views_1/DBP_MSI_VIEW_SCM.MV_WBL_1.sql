CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBL_1(
    EK_FG,
    GF_ID,
    WBL_DAT_VON,
    WBL_ID,
    WBL_NAME,
    MANDANT_ID
) AS
--2024-01-24, dknop, remove where-clause
SELECT
    v01.ek_fg,
    v01.gf_id,
    v01.wbl_dat_von,
    v01.wbl_id,
    v01.wbl_name,
    v01.mandant_id
FROM
    DBP_VIEW.v_wbl_1 v01
--WHERE
   -- v01.mandant_id = 1
   ;