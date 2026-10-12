CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGERNUMMER_WUP_ZU_2
(
lagernummer_id
,mandant_id
,nb_id
,wup_id
)
AS
   SELECT
  lagernummer_id, mandant_id, nb_id, wup_id
   FROM dbp_view.v_lagernummer_wup_zu_2;