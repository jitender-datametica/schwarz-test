CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_KJMO_SPR_ZU_2
(
kjmo
, kjmo_bez
, kjmo_bez_lang
, gjmo
)
AS
SELECT
v01.kjmo
, v01.kjmo_bez
, v01.kjmo_bez_lang
, v01.gjmo

FROM dbp_view.v_kjmo_spr_zu_2 v01

WHERE v01.spr_id = 22;