CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_F_UMSATZ_TAG_WUP_1 as
   -- FAKT-AGGREGAT Umsatz/Kunden/Offen pro Tag_1 - Markt
   -- Datenumfang:  2 GJ
   -- 17.07.2014 twie: View von VIS (mv_vis_tag_fakt_wup_1) in WWC übernommen für Planumsätze

   SELECT
   v01.mandant_id, v01.nb_id, v01.wup_id, v01.wrg_id, v01.dat, v01.ums_netto_plan

   FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_1  v01

   JOIN dbp_msi_view_wwc.mv_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id

   -- immer Landeswährung ausgeben
   WHERE v01.wrg_id = v02.wrg_id
   ;