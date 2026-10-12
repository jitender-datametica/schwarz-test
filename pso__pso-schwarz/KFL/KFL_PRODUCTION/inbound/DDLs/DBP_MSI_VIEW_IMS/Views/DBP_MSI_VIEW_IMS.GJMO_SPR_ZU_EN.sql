CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.GJMO_SPR_ZU_EN AS
-- 23.05.2013 A Lipkin erstellt
   SELECT gjmo,
   TRIM( mo_bez)  ||  ' FY ' ||  CAST(gj AS CHAR(4))  AS gjmo_bez

   FROM dbp_view.v_monat v01
   INNER JOIN dbp_view.v_monat_spr_zu v02
   ON v01.mo_kj =v02.mo_id
   WHERE v02.spr_id=24
   ;