CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_MASSNAHME
(
geku_massnahme_uid
,geku_massnahme_id
)
AS
   SELECT
   geku_massnahme_uid
   , geku_massnahme_id
   FROM dbp_view.v_l_geku_massnahme;