CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_ANTWORT_SPR_ZU_2
(
antwort_id
,umfrage_id
,kmr_quelle_id
,antwort_bez
,antwort_bez_cz
,antwort_bez_pl
,antwort_bez_sk
,antwort_bez_hr
,antwort_bez_ro
,antwort_bez_bg
)
AS
-- 20180502 twie: SPEC0037245 Neuanlage Sprachview Antwort in Maritz
--                          weitere Felder aktuell nicht benötigt
-- 20180529 twie: SPEC0038139 PK um kmr_quelle_id ergänzt für Zusammenführung Hierarchie
-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel

   SELECT

   antwort_id
   , umfrage_id
   , 2 AS kmr_quelle_id
   , MAX(CASE WHEN spr_id =   22 THEN antwort_bez ELSE NULL END)  AS antwort_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 124 THEN antwort_bez ELSE NULL END)  AS antwort_bez_cz
   , MAX(CASE WHEN spr_id =   90 THEN antwort_bez ELSE NULL END)  AS antwort_bez_pl
   , MAX(CASE WHEN spr_id = 108 THEN antwort_bez ELSE NULL END)  AS antwort_bez_sk
   , MAX(CASE WHEN spr_id =   65 THEN antwort_bez ELSE NULL END)  AS antwort_bez_hr
   , MAX(CASE WHEN spr_id =   95 THEN antwort_bez ELSE NULL END)  AS antwort_bez_ro
   , MAX(CASE WHEN spr_id =   18 THEN antwort_bez ELSE NULL END)  AS antwort_bez_bg

   FROM dbp_view.v_mcx_antwort_spr_zu_2

   GROUP BY antwort_id, umfrage_id;