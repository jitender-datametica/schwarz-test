CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ABT_SPR_ZU_2
-- 26.02.2014 twie: Länderunabhängig, gefiltert auf Mdt. 1, da andere Mdt. identische abt_id
-- 14.07.2019 pjan1603: filtering on mandant_id = 1 has been removed, SPEC0059405
(
mandant_id
, arthiertyp_id
, abt_id
, abt_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.abt_id, v01.abt_bez, v01.spr_id

   FROM dbp_view.v_abt_spr_zu_2 v01

   WHERE v01.arthiertyp_id = 2
   AND v01.spr_id = 22 -- deutsch
;