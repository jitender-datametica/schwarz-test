CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_BUCHUNGSKREIS_SPR_ZU_1 AS
-- 31.05.2013 twie: Erstellung Sprachview Buchungskreis
-- 02.07.2013 twie: Buchungskreis gibt es nicht sprachabhängig, keine weiteren Sprachviews benötigt
-- 19.08.2013 twie: keine Einschränkung auf spr_id, jeder Buks nur in einer Sprache vorhanden
-- 20.08.2013/Gia

   SELECT
   mandant_id,
   buchungskreis_id,
   CASE WHEN buchungskreis_id = -1 THEN ''
   ELSE buchungskreis_bez
   END AS buchungskreis_bez
   FROM dbp_view.v_in_buchungskreis_spr_zu_1
;