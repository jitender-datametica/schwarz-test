CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_KJMO_SPR_ZU_PL_1
   -- 20.02.2015 twie: neue Sprachtabelle für für KJMO
   (
   kjmo
   ,mo_bez_lang

   )
   AS
      SELECT

      v01.kjmo,
      TRIM(v02.mo_bez) || ' ' || TRIM(v01.kj)::VARCHAR(20) AS mo_bez_lang

      FROM dbp_view.v_monat_1 v01
      INNER JOIN dbp_view.v_monat_spr_zu_1  v02
      ON v01.mo_kj = v02.mo_id
      AND v02.spr_id = 90
;