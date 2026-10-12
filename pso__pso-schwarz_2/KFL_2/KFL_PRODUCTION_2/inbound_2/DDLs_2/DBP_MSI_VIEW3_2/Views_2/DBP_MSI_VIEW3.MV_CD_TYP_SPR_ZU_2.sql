CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_CD_TYP_SPR_ZU_2 (mandant_id, cd_typ_id, spr_id, cd_typ_bez) AS 
-- 15.11.2016, AP0006317 - Vor- und Nachlaufpaletten, srom0404 CD-Vorgang lt. Konzept nicht immer gefüllt
-- 26.07.2017, srom0404 Korrektur auf CROSS JOIN, Dummy_2 muss für jedes LAnd_2 in jeder Sprache erzeugt werden
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   t01.mandant_id,
   t01.cd_typ_id,
   t01.spr_id,
   t01.cd_typ_bez
FROM
   DBP_MSI_VIEW3.TBL_MV_CD_TYP_SPR_ZU_2 t01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v03 
   ON t01.spr_id = v03.spr_id;