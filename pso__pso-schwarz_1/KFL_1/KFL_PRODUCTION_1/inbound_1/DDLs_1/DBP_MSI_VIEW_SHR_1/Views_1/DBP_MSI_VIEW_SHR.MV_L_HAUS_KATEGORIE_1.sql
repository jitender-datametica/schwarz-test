CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_HAUS_KATEGORIE_1
(
mandant_id
,haus_kategorie_id
)
AS
   SELECT
   v01.mandant_id, v01.haus_kategorie_id

   FROM dbp_view.v_l_haus_kategorie_1 v01;