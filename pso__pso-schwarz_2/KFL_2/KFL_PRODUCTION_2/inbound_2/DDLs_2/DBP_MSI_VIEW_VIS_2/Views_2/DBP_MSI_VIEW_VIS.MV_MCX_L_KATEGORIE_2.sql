CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_KATEGORIE_2
-- 20180502 twie: SPEC0037245 Neuanlage Lookup Kategorie in Maritz
--                           Kategorie wird in DWH generiert, existiert nicht im Quellsystem Maritz

(
kat_id
,teilbereich_id
)
AS
   SELECT

   kat_id, teilbereich_id

   FROM dbp_view.v_mcx_l_kategorie_2
;