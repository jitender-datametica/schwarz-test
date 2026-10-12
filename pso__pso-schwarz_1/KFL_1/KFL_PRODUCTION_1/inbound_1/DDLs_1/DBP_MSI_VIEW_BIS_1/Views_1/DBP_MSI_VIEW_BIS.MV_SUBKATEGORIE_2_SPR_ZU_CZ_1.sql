CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_SUBKATEGORIE_2_SPR_ZU_CZ_1
-- 11.12.2012 AL initial
-- 09.12.2014 SROM. Einschränkung auf mandant_id rausgenommen
--                  Es gibt zwar für jede KMO Subkategorie einen deutschen Text,
--                  aber DE beinhaltet nicht alle KMO Subkategorien
--                  mandant_id aus View heraus und Gruppierung eingebaut (jedes KMO Land_1 hat einen deutschen Text)
(
mandant_id
,subkategorie_2_id
,spr_id
,subkategorie_2_bez
)
AS
   SELECT        min(mandant_id) AS mandant_id,
   subkategorie_2_id,
   spr_id,
   max(subkategorie_2_bez) AS subkategorie_2_bez
   FROM dbp_view.v_subkategorie_2_spr_zu_1
   --Wir gehen von identischen Subkategorien in allen Systemen, deswegen mandantenumnabhängig umgesetzt
   WHERE spr_id=124 --AND mandant_id=2
   GROUP BY subkategorie_2_id
   ,spr_id
;