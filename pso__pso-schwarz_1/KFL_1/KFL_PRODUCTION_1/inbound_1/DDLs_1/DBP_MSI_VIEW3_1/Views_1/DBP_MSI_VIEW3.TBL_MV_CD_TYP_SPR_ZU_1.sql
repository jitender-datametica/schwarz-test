CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_CD_TYP_SPR_ZU_1
-- 15.11.2016, AP0006317 - Vor- und Nachlaufpaletten, srom0404 CD-Vorgang lt. Konzept nicht immer gefüllt
-- 26.07.2017, srom0404 Korrektur auf CROSS JOIN, Dummy_1 muss für jedes LAnd_1 in jeder Sprache erzeugt werden
(
mandant_id
,cd_typ_id
,spr_id
,cd_typ_bez
)
AS
   SELECT
   t01.mandant_id, t01.cd_typ_id, t01.spr_id, t01.cd_typ_bez
   FROM
   ( --t01
   SELECT
   v01.mandant_id, v01.cd_typ_id, v01.spr_id, v01.cd_typ_bez
   FROM dbp_view.v_cd_typ_spr_zu_1 v01

   -- Dummy_1 Sätze, für nicht gefüllte Vorlauf- Nachlaufvorgänge
   UNION

   SELECT v01.mandant_id, '-1' AS cd_typ_id, v02.spr_id, 'DWH - no CD Type'
   FROM dbp_view.v_mandant_1 v01
   CROSS JOIN dbp_view.v_mandant_spr_zu_1 v02
   ) t01
;