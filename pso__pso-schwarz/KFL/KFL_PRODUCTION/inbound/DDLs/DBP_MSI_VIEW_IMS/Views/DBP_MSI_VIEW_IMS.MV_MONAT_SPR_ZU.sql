CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_MONAT_SPR_ZU
--23.05.2013 AL Init

(mo_gj
,mo_bez
)
AS
   SELECT
   CASE WHEN mo_id >= 3 THEN mo_id -2 ELSE mo_id + 10 END AS mo_gj,
   mo_bez

  FROM dbp_view.v_monat_spr_zu  v01
   WHERE spr_id=22;