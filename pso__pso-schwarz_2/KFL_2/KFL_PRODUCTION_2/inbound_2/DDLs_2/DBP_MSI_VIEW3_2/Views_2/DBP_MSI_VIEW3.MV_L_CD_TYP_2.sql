CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_CD_TYP_2
-- 13.04.2017, AP0006317 - Vor- und Nachlaufpaletten, srom0404 CD-Vorgang lt. Konzept nicht immer gefüllt
(
mandant_id
,cd_typ_id
)
AS
   SELECT mandant_id, cd_typ_id
   FROM dbp_view.v_l_cd_typ_2

   -- Dummy_2 Sätze, für nicht gefüllte Vorlauf- Nachlaufvorgänge
   UNION

   SELECT mandant_id, '-1' AS cd_typ_id
   FROM dbp_view.v_mandant_2
;