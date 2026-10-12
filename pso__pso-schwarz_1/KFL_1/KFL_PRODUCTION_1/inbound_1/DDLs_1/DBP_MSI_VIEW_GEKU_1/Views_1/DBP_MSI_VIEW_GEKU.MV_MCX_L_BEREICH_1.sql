CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_L_BEREICH_1
(
ber_id
,umfrage_id
)
AS
-- 20180502 twie: SPEC0037245 Neuanlage Lookup Bereich in Maritz
--                           Bereich wird in DWH generiert, existiert nicht im Quellsystem Maritz
-- 20190404 twie: SPEC0053317 FK auf Umfrage

   SELECT

   ber_id
   , umfrage_id

   FROM dbp_view.v_mcx_l_bereich_1;