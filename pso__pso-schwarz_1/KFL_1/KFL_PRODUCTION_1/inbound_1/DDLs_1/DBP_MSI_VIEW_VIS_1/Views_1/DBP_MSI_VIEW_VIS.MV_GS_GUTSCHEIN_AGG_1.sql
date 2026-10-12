CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_GUTSCHEIN_AGG_1
AS
   -- FAKT Geschenk-Karten [gutschein_1] - aggregiert + Betrag Gruppierung
   -- 2010KW17 GSS Redesign + Rollout KMO

   SELECT
   mv01.mandant_id, mv01.dat, mv01.transaktion_id  --> Status_1
   , mv01.ausgeber_id  --> Grund
   , mv01.ausgeber_typ_id  --> Bereich
   , mv01.wrg_id, SUM(1)::INTEGER    AS gutschein_anzahl_agg, SUM(mv01.gutschein_betrag)  AS gutschein_betrag_agg, mv01.wup_id, mv01.nb_id, mv01.buchungskreis_id, mv01.gs_kostenstelle_id, mv01.gs_kostenstelle_bez, v02.betrag_von

   FROM dbp_msi_view_vis.mv_gs_gutschein_1  mv01
   INNER JOIN dbp_view.v_l_gs_betrag_1 v02
   ON mv01.mandant_id = v02.mandant_id
   AND mv01.ausgeber_typ_id = v02.ausgeber_typ_id
   AND mv01.gutschein_betrag BETWEEN v02.betrag_von AND v02.betrag_bis
   AND mv01.wrg_id = v02.wrg_id

   WHERE mv01.transaktion_id IN (4, 6, 7)

   GROUP BY
   mv01.mandant_id
   , mv01.transaktion_id
   , mv01.ausgeber_id
   , mv01.ausgeber_typ_id
   , mv01.dat
   , mv01.wrg_id
   , mv01.wup_id
   , mv01.nb_id
   , mv01.buchungskreis_id
   , mv01.gs_kostenstelle_id
   , mv01.gs_kostenstelle_bez
   , v02.betrag_von
   ;