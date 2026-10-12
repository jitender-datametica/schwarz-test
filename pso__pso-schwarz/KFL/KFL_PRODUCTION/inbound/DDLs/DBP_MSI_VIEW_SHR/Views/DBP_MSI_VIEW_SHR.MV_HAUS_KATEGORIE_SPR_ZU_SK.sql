CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_HAUS_KATEGORIE_SPR_ZU_SK
(
mandant_id
,haus_kategorie_id
,spr_id
,haus_kategorie_bez


)
AS
   SELECT
   v01.mandant_id, v01.haus_kategorie_id, v01.spr_id, v01.haus_kategorie_bez



   FROM dbp_view.v_haus_kategorie_spr_zu v01
   where spr_id = 108


;