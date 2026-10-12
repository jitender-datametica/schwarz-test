CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_VERBUND_HELPER
AS
   -- HELPER : Verbundfilialen auf Basis nils_verteilgebiet_id
   -- REKURSION wird von mv_wup_verbund_helper benoetigt
   -- 2012KW46 Initial (Q2)

   SELECT
   w01.mandant_id, w01.nb_id, w01.wup_id, w01.wup_standort, w01.nils_verteilgebiet_id AS verteilgebiet_id, COALESCE(TRIM(w02.wup_id),'-') AS v_wup_id, COALESCE(w02.wup_standort,'-') AS v_wup_standort, RANK() OVER (PARTITION BY w01.mandant_id, w01.wup_id ORDER BY w01.mandant_id, w01.wup_id, w02.wup_id)::BYTEINT AS wup_count
   FROM dbp_msi_view_vis.mv_wup w01
   LEFT JOIN dbp_msi_view_vis.mv_wup w02
   ON w01.mandant_id = w02.mandant_id
   AND w01.nils_verteilgebiet_id = w02.nils_verteilgebiet_id
   AND w01.wup_id <> w02.wup_id

   WHERE w01.nb_id = 0
   AND w01.nils_verteilgebiet_id > 0;