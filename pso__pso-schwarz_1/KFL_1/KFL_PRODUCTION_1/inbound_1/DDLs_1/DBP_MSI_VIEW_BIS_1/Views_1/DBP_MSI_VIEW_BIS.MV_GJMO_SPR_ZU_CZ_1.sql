CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_GJMO_SPR_ZU_CZ_1 as

   SELECT gjmo,
   TRIM( mo_bez)  ||   ' GJ ' ||   cast(gj AS CHAR(4))  AS gjmo_bez


   FROM dbp_view.v_monat_1 v01
   INNER JOIN dbp_view.v_monat_spr_zu_1 v02
   ON v01.mo_kj =v02.mo_id
   WHERE v02.spr_id=124;