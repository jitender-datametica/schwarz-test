CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_L_FRAGE_2
(
frage_id
,umfrage_id
,frage_ex_typ
,frage_status
)
AS
-- 20180502 twie: SPEC0037245 Neuanlage Lookup Frage in Maritz
--                           Eltern von Antwort, keine eindeutige Zuordnung zu Kategorie und Bereich
-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel

   SELECT

   frage_id
   , umfrage_id
   , frage_ex_typ
   , frage_status

   FROM dbp_view.v_mcx_l_frage_2;