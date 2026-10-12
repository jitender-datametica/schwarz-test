CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_WTAG_SPR_ZU_2
(
wtag_id
, wtag_bez
, wtag_kbez
)
AS
SELECT
v01.wtag_id
, v01.wtag_bez
, UPPER(SUBSTRING(v01.wtag_bez , 1 , 2)) AS wtag_kbez

FROM dbp_view.v_wtag_spr_zu_2 v01
WHERE v01.spr_id = 22;