CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_MASSNAHME_1 AS
-- 23.07.2019 twie: SPEC0059595 Lookup für Massnahmenart
-- statt massnahmenart_id wird die massnahme_id als PK genommen, ist 1:1 zugeordnet

   SELECT

   massnahme_id,
   massnahmenart_id

   FROM dbp_view.v_l_massnahme_1;