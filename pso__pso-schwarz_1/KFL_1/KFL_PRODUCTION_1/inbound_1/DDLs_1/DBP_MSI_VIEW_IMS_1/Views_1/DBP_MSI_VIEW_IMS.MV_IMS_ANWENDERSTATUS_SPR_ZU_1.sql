CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IMS_ANWENDERSTATUS_SPR_ZU_1 AS
-- 20.08.2013 twie: Erstellung Sprachview Anwenderstatus
-- 20.08.2013 twie: nur deutsche View, keine Übersetzungen vorhanden, Attribut sprachunabhängig

   SELECT
   anwenderstatus_id,
   mandant_id,
   anwenderstatus_bez_kurz,
   anwenderstatus_bez

  FROM dbp_view.v_ims_anwenderstatus_spr_zu_1
  WHERE spr_id = 22
;