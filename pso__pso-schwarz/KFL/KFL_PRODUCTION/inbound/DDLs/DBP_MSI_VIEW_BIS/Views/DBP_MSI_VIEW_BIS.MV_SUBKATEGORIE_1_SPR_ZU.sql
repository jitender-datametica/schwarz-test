CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_SUBKATEGORIE_1_SPR_ZU
   -- 11.12.2012 AL initial
   -- 09.12.2014 SROM. Einschränkung auf mandant_id rausgenommen
   --                  Es gibt zwar für jede KMO Subkategorie einen deutschen Text,
   --                  aber DE beinhaltet nicht alle KMO Subkategorien
   --                  mandant_id aus View heraus und Gruppierung eingebaut (jedes KMO Land hat einen deutschen Text)
   (
   subkategorie_1_id
   ,spr_id
   ,subkategorie_1_bez
   )
   AS
      SELECT subkategorie_1_id,
      spr_id,
      MAX(subkategorie_1_bez) AS subkategorie_1_bez
      FROM dbp_view.v_subkategorie_1_spr_zu
      WHERE spr_id = 22 --AND mandant_id = 1
      GROUP BY subkategorie_1_id
      ,spr_id
;