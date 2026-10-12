CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MONAT_SPR_ZU_SK
--11.01.2013SHoger initial
(mo_gj
,mo_bez
)
AS
   SELECT
   CASE WHEN mo_id >= 3 THEN mo_id -2 ELSE mo_id + 10 END AS mo_gj,
   mo_bez

  FROM dbp_view.v_monat_spr_zu  v01
   where spr_id=108
;