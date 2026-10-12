CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MONAT_SPR_ZU_CZ
(
kjmo
,gjmo
,mo_id
,mo_bez
,spr_id
)
AS
   SELECT
   v01.kjmo, v01.gjmo, v02.mo_id, v02.mo_bez, v02.spr_id
   FROM dbp_view.v_monat v01
   INNER JOIN dbp_view.v_monat_spr_zu v02
   ON v01.mo_kj = v02.mo_id
   WHERE spr_id = 124 -- Tschechien
   and  v01.AKT_KJ BETWEEN -3 AND 3
   ;