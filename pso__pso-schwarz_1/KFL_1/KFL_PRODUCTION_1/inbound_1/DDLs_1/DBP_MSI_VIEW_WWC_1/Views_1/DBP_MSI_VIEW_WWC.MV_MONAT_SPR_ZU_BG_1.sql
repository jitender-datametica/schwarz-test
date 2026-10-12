CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MONAT_SPR_ZU_BG_1
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
   FROM dbp_view.v_monat_1 v01
   INNER JOIN dbp_view.v_monat_spr_zu_1 v02
   ON v01.mo_kj = v02.mo_id
   WHERE spr_id = 18 -- Bulgarien
   and  v01.AKT_KJ BETWEEN -3 AND 3
   ;