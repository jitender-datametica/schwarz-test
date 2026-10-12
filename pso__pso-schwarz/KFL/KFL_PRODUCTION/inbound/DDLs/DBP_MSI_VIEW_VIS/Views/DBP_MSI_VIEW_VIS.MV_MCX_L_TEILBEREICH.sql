CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_TEILBEREICH
-- 20180509 twie: SPEC0037245 Neuanlage Lookup Teilbereich in Maritz
--                           Teilbereich wird in DWH generiert, existiert nicht im Quellsystem Maritz

(
teilbereich_id
,ber_id
)
AS
   SELECT

   teilbereich_id, ber_id

   FROM dbp_view.v_mcx_l_teilbereich
;