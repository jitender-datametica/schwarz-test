CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_MASSNAHMENART_SPR_ZU AS
-- 23.07.2019 twie: SPEC0059595 Sprachtabelle für Massnahmenart
-- statt massnahmenart_id wird die massnahme_id als PK genommen, ist 1:1 zugeordnet

   SELECT

   v01.massnahme_id,
   v02.massnahmenart_bez

   FROM dbp_view.v_l_massnahme v01
   LEFT JOIN dbp_view.v_massnahmenart_spr_zu v02
   ON v01.massnahmenart_id = v02.massnahmenart_id

   WHERE v02.spr_id = 22
   ;