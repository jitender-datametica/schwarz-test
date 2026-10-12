CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_SUBKATEGORIE_1_1
-- 11.12.2012 AL initial
-- 04.02.2014 twie: Mdt Filter raus, da es nicht in allen Ländern die gleichen IDs geben muss

(
mandant_id
,subkategorie_1_id
)
AS
   SELECT     MIN(mandant_id),
   subkategorie_1_id
   FROM dbp_view.v_l_subkategorie_1_1
   --Wir gehen von identischen Subkategorien in allen Systemen, deswegen mandantenumnabhängig umgesetzt
   --WHERE mandant_id=1
   GROUP BY subkategorie_1_id
;