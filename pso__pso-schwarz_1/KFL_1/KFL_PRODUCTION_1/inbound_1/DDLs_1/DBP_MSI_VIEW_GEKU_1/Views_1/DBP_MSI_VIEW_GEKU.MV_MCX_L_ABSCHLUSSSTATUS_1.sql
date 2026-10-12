CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_L_ABSCHLUSSSTATUS_1
(
abschluss_id
,umfrage_id
,abschluss_bez
)
-- 20180502 twie: SPEC0037245 Neuanlage Lookup Abschlussstatus in Maritz
-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel

AS
   SELECT

   abschluss_id
   , umfrage_id
   , abschluss_bez

   FROM dbp_view.v_mcx_l_abschlussstatus_1;