CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_VERTEILGEBIET_1
(
verteilgebiet_uid
,verteilgebiet_bez
,nils_verteilgebiet_id
,mandant_id
)
AS
   SELECT
   v01.verteilgebiet_uid, v01.verteilgebiet_bez, nils_verteilgebiet_id, mandant_id
   FROM dbp_view.v_geku_verteilgebiet_1 v01
   WHERE CONTAINS( v01.verteilgebiet_bez, 'TIP')
;