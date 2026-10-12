CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_FRAGE_SPR_ZU_1
(
frage_id
,umfrage_id
,frage_bez
,frage_bez_cz
,frage_bez_pl
,frage_bez_sk
,frage_bez_hr
,frage_bez_ro
,frage_bez_bg
)
AS
-- 20180502 twie: SPEC0037245 Neuanlage Sprachview Frage in Maritz
--                          weitere Felder aktuell nicht benötigt
-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel

   SELECT

   frage_id
   , umfrage_id
   , MAX(CASE WHEN spr_id =   22 THEN frage_bez ELSE NULL END)  AS frage_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 124 THEN frage_bez ELSE NULL END)  AS frage_bez_cz
   , MAX(CASE WHEN spr_id =   90 THEN frage_bez ELSE NULL END)  AS frage_bez_pl
   , MAX(CASE WHEN spr_id = 108 THEN frage_bez ELSE NULL END)  AS frage_bez_sk
   , MAX(CASE WHEN spr_id =   65 THEN frage_bez ELSE NULL END)  AS frage_bez_hr
   , MAX(CASE WHEN spr_id =   95 THEN frage_bez ELSE NULL END)  AS frage_bez_ro
   , MAX(CASE WHEN spr_id =   18 THEN frage_bez ELSE NULL END)  AS frage_bez_bg

   FROM dbp_view.v_mcx_frage_spr_zu_1

   GROUP BY frage_id, umfrage_id;