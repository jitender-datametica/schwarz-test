CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_KOSTENART_SPR_ZU_HR_2
-- 22.03.2013 twie: Sprachzuordung für Kostenarten
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 20.08.2013 twie: mandant_id nicht mit ausgeben
-- 20.08.2013/Gia

AS
   SELECT  LTRIM(collate(de.kostenart_id,''),'0') AS kostenart_id,
           de.krk_id,
           COALESCE(ls.kostenart_bez, de.kostenart_bez) AS kostenart_bez
   FROM  dbp_view.v_kostenart_spr_zu_2  de
   LEFT OUTER JOIN
   (
     SELECT *
     FROM  dbp_view.v_kostenart_spr_zu_2
     WHERE spr_id = 65
     AND krk_id='XX01'
     AND mandant_id = 1
   ) ls
   ON de.kostenart_id = ls.kostenart_id
   WHERE de.spr_id = 22
     AND de.krk_id='XX01'
     AND de.mandant_id = 1
   ;