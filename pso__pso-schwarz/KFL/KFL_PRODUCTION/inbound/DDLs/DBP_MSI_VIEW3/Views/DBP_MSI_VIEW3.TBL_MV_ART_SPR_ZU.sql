CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_ART_SPR_ZU AS
-- 20230718 staeblern  - CAST bei Art_id_Bez entfernen. wird nicht benoetigt und fuehrt zu fehler, wenn wir mehr Zeichen haben 
SELECT
   v01.spr_id,
   v01.art_id,
   v01.mandant_id,
   v01.art_bez,
   CAST(v01.art_id AS CHAR(10)) || ' ' || v01.art_bez  AS art_id_bez
FROM
   dbp_view.v_art_spr_zu v01;