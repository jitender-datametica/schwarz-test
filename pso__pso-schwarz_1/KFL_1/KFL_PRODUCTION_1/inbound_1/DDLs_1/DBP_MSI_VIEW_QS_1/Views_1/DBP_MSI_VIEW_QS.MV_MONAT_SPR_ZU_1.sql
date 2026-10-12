CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_MONAT_SPR_ZU_1
(
mo_id
, mo_bez
)
AS
SELECT
v01.mo_id
, v01.mo_bez

FROM dbp_view.v_monat_spr_zu_1 v01

WHERE v01.spr_id = 22;